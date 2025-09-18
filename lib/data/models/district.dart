class District {
  final String code;
  final String fullName;

  District({required this.code, required this.fullName});

  /// Parse từ JSON (Map)
  factory District.fromJson(Map<String, dynamic> json) {
    return District(code: json['code'] ?? '', fullName: json['fullName'] ?? '');
  }

  /// Convert sang JSON (Map)
  Map<String, dynamic> toJson() {
    return {'code': code, 'fullName': fullName};
  }

  @override
  String toString() => 'District(code: $code, fullName: $fullName)';
}
