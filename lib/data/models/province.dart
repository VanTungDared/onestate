class Province {
  final String code;
  final String fullName;

  Province({required this.code, required this.fullName});

  /// Parse từ JSON (Map)
  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(code: json['code'] ?? '', fullName: json['fullName'] ?? '');
  }

  /// Convert sang JSON (Map)
  Map<String, dynamic> toJson() {
    return {'code': code, 'fullName': fullName};
  }

  @override
  String toString() => 'Province(code: $code, fullName: $fullName)';
}
