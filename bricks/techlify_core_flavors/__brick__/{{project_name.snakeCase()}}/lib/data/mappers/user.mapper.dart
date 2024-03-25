import 'package:togo_mobile/config/extensions.dart';
import 'package:togo_mobile/data/responses/user.response.dart';
import 'package:togo_mobile/domain/models/user.model.dart';

extension UserMapper on UserResponse {
  User toDomain() {
    return User(
      id.orZero(),
      name.orEmpty(),
      email.orEmpty(),
    );
  }
}

extension UserListMapper on List<UserResponse> {
  List<User> toDomain() {
    final List<User> userList = [];

    for (int i = 0; i < length; i++) {
      userList.add(this[i].toDomain());
    }
    return userList;
  }
}
