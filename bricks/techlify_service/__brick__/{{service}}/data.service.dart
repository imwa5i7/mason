import 'dart:convert';
import 'dart:io';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:techlify_core/src/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'auth.service.dart';
import 'config.dart';

typedef ErrorToastCustomWidget = ToastMessage? Function(http.Response response);

enum Env { local, hosted }

class CustomUri {
  static Env env = Config().readValue<String>('env') == 'local' ? Env.local : Env.hosted;

  static Uri parse(String? url, [Map<String, String>? params]) {
    if (env == Env.local) {
      return Uri.http(
        Config().readValue<String>('coreDomain'),
        Config().readValue<String>('baseUri') + url!,
        params,
      );
    } else
      return Uri.https(
        Config().readValue<String>('coreDomain'),
        Config().readValue<String>('baseUri') + url!,
        params,
      );
  }
}

class DataService {
  static bool isButtonDisabled = false;
  static Env env = Config().readValue<String>('env') == 'local' ? Env.local : Env.hosted;
  static Future<Map<String, String>> getHeaders() async {
    final accessToken = await AuthService.getAccessToken();

    var data = {
      HttpHeaders.contentTypeHeader: 'application/json',
      if (accessToken != null && accessToken.isNotEmpty) HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    };
    return data;
  }

  static Future<bool> checkIsInternetConnected() async {
    bool isInternet = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return isInternet = true;
      }
    } on SocketException catch (_) {
      throw NoInernetExpceptopn('No Internet Connection!');
    }
    return isInternet;
  }

  static Future<Map?> get(String? url,
      {Map<String, String>? params, bool enableCache = false, ErrorToastCustomWidget? customToast, bool showToast = true}) async {
    //Method to check actual internet connection

    bool isConnected = await checkIsInternetConnected();

    Future<Map?> getResponse() async {
      http.Response response = await http.get(
        CustomUri.parse(url, params),
        headers: await DataService.getHeaders(),
      );
      // if (response.statusCode != 200 && response.statusCode != 201) {
      try {
        // if (json.decode(response.body).containsKey('error') && showToast) {
        //   Fluttertoast.showToast(
        //       msg: json.decode(response.body)['error'].toString());
        // } else if (customToast != null) {
        //   customToast(response);
        // }

        return _returnResponse(
          response,
          enableCache: enableCache,
          showToast: showToast,
          key: url,
          customToast: customToast,
        );
        // return response.body.isNotEmpty
        //     ? (json.decode(response.body) is List)
        //         ? {'data': json.decode(response.body)}
        //         : json.decode(response.body)
        //     : {"item": []};
      } on FormatException catch (err) {
        if (showToast)
          Fluttertoast.showToast(
            msg: 'Failed to fetch data',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        throw InvalidInputException('Format Exception: $err');
      }
      // on Exception catch (_) {}
      // return {'error': "Failed to fetch data"};
    }
    // } else {
    // if (enableCache) {
    //   APICacheDBModel cacheDBModel =
    //       APICacheDBModel(key: url!, syncData: response.body);
    //   await APICacheManager().addCacheData(cacheDBModel);
    // }
    // return response.body.isNotEmpty
    //     ? (json.decode(response.body) is List)
    //         ? {'data': json.decode(response.body)}
    //         : json.decode(response.body)
    //     : {"item": []};
    // }
    // }

    if (enableCache && !isConnected) {
      var data = await getCache(url!);
      if (data != null)
        return data;
      else
        return getResponse();
    } else
      return getResponse();
  }

  static Future<Map?> getCache(
    String key,
  ) async {
    var isCacheExists = await APICacheManager().isAPICacheKeyExist(key);
    if (!isCacheExists) {
      return null;
    } else {
      var cacheData = await APICacheManager().getCacheData(key);

      return cacheData.syncData.isNotEmpty
          ? (json.decode(cacheData.syncData) is List)
              ? {'data': json.decode(cacheData.syncData)}
              : json.decode(cacheData.syncData)
          : null;
    }
  }

  static Future<void> emptyCache() async {
    await APICacheManager().emptyCache();
  }

  static Future<Map?> post(String? url, Map? data, {bool showToast = true, Map<String, String>? params, ErrorToastCustomWidget? customToast}) async {
    var result;
    try {
      var fullUrl = CustomUri.parse(url, params);
      http.Response response = await http.post(
        fullUrl,
        body: json.encode(data),
        headers: await DataService.getHeaders(),
      );
      // if (response.statusCode != 200 && response.statusCode != 201) {
      //   if (showToast && customToast == null)
      //     Fluttertoast.showToast(
      //       msg: response.body.isNotEmpty
      //           ? jsonDecode(response.body)['error']?.toString() ??
      //               'Failed to create data'
      //           : "Failed to create a data",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //     );
      //   else if (customToast != null) {
      //     customToast(response);
      //   }
      // } else {
      result = _returnResponse(response, showToast: showToast, customToast: customToast);
      // }
    } catch (_) {}
    return result;
  }

  static Future<Map?> postMultipart(String url, Map<String, dynamic> data) async {
    var request = http.MultipartRequest('POST', CustomUri.parse(url));
    request.headers.addAll(await DataService.getHeaders());
    request.fields.addAll(data['body']);
    if (data['files'].isNotEmpty) {
      for (int i = 0; i < data['files'].length; i++) {
        request.files.add(await http.MultipartFile.fromPath(data['files'][i]['field'], data['files'][i]['file'].path));
      }
    }

    var jsonResponse;
    try {
      http.StreamedResponse streamResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamResponse);
      jsonResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return jsonResponse;
  }

  static Future<Map?> postRaw(String url, data) async {
    var result;
    try {
      isButtonDisabled = true;
      Response response = await Dio().post(
        CustomUri.parse(url).toString(),
        data: data,
        options: Options(
          headers: await DataService.getHeaders(),
        ),
      );

      isButtonDisabled = false;
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
          msg: "Failed to create a data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        var dataList = response.data.values.toList();
        result = dataList[0];
      }
    } catch (_) {}
    return result;
  }

  static Future<Map?> put(String url, Map data, {Map<String, String>? params, bool showToast = true, ErrorToastCustomWidget? customToast}) async {
    var result;
    try {
      isButtonDisabled = true;
      var fullUrl = CustomUri.parse(url, params);
      http.Response response = await http.put(
        fullUrl,
        body: json.encode(data),
        headers: await DataService.getHeaders(),
      );
      isButtonDisabled = false;
      // if (response.statusCode != 200 && response.statusCode != 201) {
      try {
        // if (json.decode(response.body).containsKey('error') && showToast)
        //   Fluttertoast.showToast(
        //       msg: json.decode(response.body)['error'].toString());
        // else if (customToast != null) {
        //   customToast(response);
        // }
        result = _returnResponse(response, showToast: showToast, customToast: customToast);
      } on FormatException catch (_) {
        if (showToast)
          Fluttertoast.showToast(
            msg: 'Failed to update data',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        throw InvalidInputException('Format Exception: Unable to Parse Data');
      } catch (_) {}
      // } else {
      // result = json.decode(response.body);
      // }
    } catch (_) {}
    return result;
  }

  static Future<Map?> delete(String url, {bool showToast = true, ErrorToastCustomWidget? customToast}) async {
    var result;
    try {
      isButtonDisabled = true;
      var fullUrl = CustomUri.parse(url, null);
      http.Response response = await http.delete(
        fullUrl,
        headers: await DataService.getHeaders(),
      );
      isButtonDisabled = false;
      // if (response.statusCode != 200) {
      //   if (showToast) {
      //     Fluttertoast.showToast(
      //       msg: "Failed to delete",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //     );
      //   } else if (customToast != null) {
      //     customToast(response);
      //   }
      // } else {
      result = _returnResponse(response, showToast: showToast, customToast: customToast);
      // }
    } catch (_) {}
    return result;
  }

  static Future<Map?> patch(String url, Map data, {ErrorToastCustomWidget? customToast}) async {
    var result;
    try {
      isButtonDisabled = true;
      var fullUrl = CustomUri.parse(url, null);
      http.Response response = await http.patch(
        fullUrl,
        body: json.encode(data),
        headers: await DataService.getHeaders(),
      );
      isButtonDisabled = false;
      // if (response.statusCode != 200) {
      //   Fluttertoast.showToast(
      //     msg: response.body.isNotEmpty
      //         ? jsonDecode(response.body)['error'] ?? 'Failed to update'
      //         : "Failed to update",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //   );
      // } else {
      // if (customToast != null) {
      //   customToast(response);
      // }
      result = _returnResponse(response, customToast: customToast);
      // }
    } catch (_) {}
    return result;
  }
}

dynamic _returnResponse(http.Response response, {bool enableCache = false, bool showToast = false, String? key, ErrorToastCustomWidget? customToast}) {
  switch (response.statusCode) {
    case 200:
      if (enableCache) {
        APICacheDBModel cacheDBModel = APICacheDBModel(key: key!, syncData: response.body);
        APICacheManager().addCacheData(cacheDBModel);
      }
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 201:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      _showToast(showToast, customToast, response);
      throw BadRequestException('Bad Request Exception : ${(response.statusCode)}');
    case 401:
      _showToast(showToast, customToast, response);

      throw UnauthorisedException('Unauthenticated : ${(response.statusCode)}');

    case 403:
      _showToast(showToast, customToast, response);

      throw UnauthorisedException('Forbidden : ${(response.statusCode)}');
    case 404:
      _showToast(showToast, customToast, response);

      throw BadRequestException('Url not found : ${(response.statusCode)}');
    case 422:
      _showToast(showToast, customToast, response);

      throw InvalidInputException('Validation error : ${(response.statusCode)}');
    case 500:
      _showToast(showToast, customToast, response);
      throw FetchDataException('Server Error : ${response.statusCode}');

    default:
      _showToast(showToast, customToast, response);
      throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

_showToast(bool showToast, ErrorToastCustomWidget? customToast, http.Response response) {
  if (showToast) {
    Fluttertoast.showToast(
      msg: response.body.isNotEmpty ? jsonDecode(response.body)['error']?.toString() ?? 'Something went wrong!' : 'Something wen wrong!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  } else if (customToast != null) {
    customToast(response);
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}

class NoInernetExpceptopn extends AppException {
  NoInernetExpceptopn([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
