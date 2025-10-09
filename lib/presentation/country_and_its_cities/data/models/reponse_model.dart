abstract class ResponseModel<T> {
  ResponseModel();
  // Union classes
  factory ResponseModel.success({
    dynamic data,
    String? message,
    String? status,
    String? accessToken,
  }) = SuccessResponseModel;
  factory ResponseModel.error({required String error}) = ErrorResponseModel;
}

class SuccessResponseModel<T> extends ResponseModel<T> {
  final dynamic data;
  final String? message;
  final String? status;
  final String? accessToken;


  SuccessResponseModel({this.data, this.message, this.status, this.accessToken});
}

class ErrorResponseModel<T> extends ResponseModel<T> {
  final String error;

  ErrorResponseModel({required this.error});
}
