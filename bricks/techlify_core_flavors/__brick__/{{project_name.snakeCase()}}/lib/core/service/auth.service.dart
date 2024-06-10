import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:{{project_name.snakeCase()}}/models/user.response.dart';
import 'package:{{project_name.snakeCase()}}/components/shared/toast.dart';
import 'package:intl/intl.dart';
import '../config/config.dart';
import 'data.service.dart';
import 'package:http/http.dart' as http;
import 'storage.service.dart';

class AuthService {
  static User? user;
  static Future authenticate(String? accessToken,
      {int? expiresIn, String? expiresAtDate}) async {
    await StorageService.store(
        GlobalConfig().readValue<String>('accessTokenKey'), accessToken);
    await setUser();
    int? expiresAt;

    if (expiresIn != null) {
      expiresAt = DateTime.now().millisecondsSinceEpoch + (expiresIn * 1000);
    }

    if (expiresAtDate != null) {
      expiresAt =
          DateFormat('yyyy-MM-dd').parse(expiresAtDate).millisecondsSinceEpoch;
    }
    return StorageService.store(
        GlobalConfig().readValue<String>('expiryTsKey'), expiresAt);
  }

  static Future<void> setUser() async {
    var data = await DataService.get("api/user/current");
    if (data != null) {
      await StorageService.store(
          GlobalConfig().readValue<String>('userStoreKey'),
          jsonEncode(data['user']));
    }
  }

  static Future<User?> getCurrentUser([reload = false]) async {
    if (user != null && !reload) {
      return user;
    }
    String? data = await StorageService.read(
        GlobalConfig().readValue<String>('userStoreKey'));
    if (data != null) {
      user = User.fromJson(jsonDecode(data));
      return user;
    }
    return null;
  }

  static Future<bool> isLoggedIn() async {
    var expiresAt = await StorageService.read(
        GlobalConfig().readValue<String>('expiryTsKey'));
    console(expiresAt);
    if (expiresAt == null) {
      return false;
    }
    int now = DateTime.now().millisecondsSinceEpoch;
    console(now);
    return (int.parse(expiresAt) > now);
  }

  static Future<String?> getAccessToken() async {
    var token = await StorageService.read(
        GlobalConfig().readValue<String>('accessTokenKey'));
    return token;
  }

  static Future<bool> logout() async {
    await StorageService.clear();
    return true;
  }

  Future<bool> login(String email, String password, Function loading) async {
    try {
      loading();
      var data = {
        "client_id": GlobalConfig().readValue<int>('apiClientId'),
        "client_secret": GlobalConfig().readValue<String>('apiClientSecret'),
        "grant_type": GlobalConfig().readValue<String>('apiGrantType'),
        "username": email,
        "password": password,
      };

      final http.Response response = await http.post(
        CustomUri.parse('oauth/token'),
        body: json.encode(data),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      final responseData = json.decode(response.body);
      log(responseData.toString());
      if (response.statusCode != 200) {
        loading();
        ToastMessage(message: 'Incorrect email or password, please try again');
        return false;
      }
      ToastMessage(message: "Successfully logged in");

      await AuthService.authenticate(
        responseData['access_token'],
        expiresIn: responseData['expires_in'],
      );
      return true;
    } catch (e) {
      console(e);
      return false;
    }
  }
}
