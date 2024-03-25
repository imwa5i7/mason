import 'package:{{project_name.snakeCase()}}/data/mappers/user.mapper.dart';
import 'package:{{project_name.snakeCase()}}/data/error_handling/api_response.dart';
import 'package:{{project_name.snakeCase()}}/data/error_handling/error_handling.dart';
import 'package:{{project_name.snakeCase()}}/data/responses/base/base.users.response.dart';
import 'package:{{project_name.snakeCase()}}/data/responses/user.response.dart';
import 'package:{{project_name.snakeCase()}}/data/service/data.service.dart';
import 'package:{{project_name.snakeCase()}}/domain/models/user.model.dart';
import 'package:{{project_name.snakeCase()}}/domain/repository/user_repo.dart';

class UserRepoImpl extends UserRepo {
  @override
  Future<ApiResponse> getUsers() async {
    try {
      final data = await DataService.get("users/get-users");
      BaseUsersResponse response = BaseUsersResponse.fromJson(data!);
      List<User> usersList = response.userList!.toDomain();
      return ApiResponse.completed(usersList);
    } catch (err) {
      return ErrorHandling.returnException(err);
    }
  }

  @override
  Future<ApiResponse> getCurrentUser() async {
    try {
      final data = await DataService.get("users/current-user");
      User user = UserResponse.fromJson(data!).toDomain();
      return ApiResponse.completed(user);
    } catch (err) {
      return ErrorHandling.returnException(err);
    }
  }
}
