import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/core/others/error_handling/api_response.dart';

class BaseBloc extends StateNotifier<ApiResponse> {
  BaseBloc(super.state);

  setState(ApiResponse apiResponse) {
    state = apiResponse;
  }
}
