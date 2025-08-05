class BaseResponse<T> {
  final int status;
  final bool success;
  final String message;
  final T data;

  BaseResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return BaseResponse<T>(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }
}
