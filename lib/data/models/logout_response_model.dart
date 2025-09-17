class LogoutResponse {
  final String message;
  final int statusCode;
  final int timestamp;

  LogoutResponse({
    required this.message,
    required this.statusCode,
    required this.timestamp,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      timestamp: json['timestamp'] ?? 0,
    );
  }
}
