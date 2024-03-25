class BaseResponse {
  int? status;
  String? message;

  BaseResponse({this.message, this.status});

  BaseResponse.fromJson(json) {
    status = json['status'];
    message = json['message'];
  }
}
