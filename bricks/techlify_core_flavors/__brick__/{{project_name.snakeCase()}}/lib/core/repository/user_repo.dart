import 'package:{{project_name.snakeCase()}}/core/others/api_response.dart';
import 'package:{{project_name.snakeCase()}}/core/repository/base_repo.dart';

class UserRepo extends BaseRepo<dynamic, ApiResponse> {
  @override
  Future<ApiResponse> show([int? id]) async {
    // TODO: implement delete
    throw UnimplementedError();
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
