import '../user.response.dart';

import 'base.response.dart';

class BaseUsersResponse extends BaseResponse {
  List<UserResponse>? userList;
  BaseUsersResponse({message, status}) : super(message: message, status: status);

  BaseUsersResponse.fromJson(Map json) : super.fromJson(json) {
    if (json['data'] != null) {
      userList = (json['data'] as List<dynamic>).map((e) => UserResponse.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      userList = [];
    }
  }
}
