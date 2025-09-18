class Ward {
  final String code;
  final String fullName;

  Ward({required this.code, required this.fullName});

  /// Parse từ JSON (Map)
  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(code: json['code'] ?? '', fullName: json['fullName'] ?? '');
  }

  /// Convert sang JSON (Map)
  Map<String, dynamic> toJson() {
    return {'code': code, 'fullName': fullName};
  }

  @override
  String toString() => 'Ward(code: $code, fullName: $fullName)';
}
