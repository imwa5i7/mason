import 'package:{{project_name.snakeCase()}}/core/constants/strings.dart';
import 'package:{{project_name.snakeCase()}}/core/others/api_response.dart';
import 'package:{{project_name.snakeCase()}}/core/others/error_handling.dart';
import 'package:{{project_name.snakeCase()}}/core/repository/base_repo.dart';
import 'package:{{project_name.snakeCase()}}/models/employee.response.dart';
import 'package:{{project_name.snakeCase()}}/models/user.response.dart';
import 'package:{{project_name.snakeCase()}}/core/services/data.service.dart';

class UserRepo extends BaseRepo<dynamic, ApiResponse> {
  @override
  Future<ApiResponse> show([int? id]) async {
    try {
      final data = await DataService.get("api/user/current");
      if (data?['user'] == [] || data?['user']?.isEmpty) {
        return ApiResponse.error('User is Empty');
      }
      User user = User.fromJson(data!['user']);
      return ApiResponse.completed(user);
    } catch (err) {
      return ErrorHandling.returnException(err);
    }
  }

  Future<ApiResponse> currentEmployee([int? id]) async {
    try {
      final data = await DataService.get("api/current-user/employee");
      if (data != null && data.containsKey('item')) {
        Employee employee = Employee.fromJson(data['item']);
        return ApiResponse.completed(employee);
      }
      return ApiResponse.error(Strings.somethingWentWrong);
    } catch (err) {
      return ErrorHandling.returnException(err);
    }
  }

  @override
  Future<ApiResponse> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> index(int page, [filter]) {
    // TODO: implement index
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> store(Map data) {
    // TODO: implement store
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> update(int id, Map data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
