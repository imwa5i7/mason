import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:togo_mobile/data/error_handling/api_response.dart';

class BaseBloc extends StateNotifier<ApiResponse> {
  BaseBloc(super.state);

  setState(ApiResponse apiResponse) {
    state = apiResponse;
  }
}
