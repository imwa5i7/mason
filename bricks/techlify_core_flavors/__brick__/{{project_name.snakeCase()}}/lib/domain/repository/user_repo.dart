import 'package:{{project_name.snakeCase()}}/data/error_handling/api_response.dart';

abstract class UserRepo {
  Future<ApiResponse> getUsers();
  Future<ApiResponse> getCurrentUser();
}
