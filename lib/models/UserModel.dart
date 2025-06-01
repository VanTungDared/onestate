class District {
  final String code;
  final String name;

  District({
    required this.code,
    required this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String status;
  final String permissionGroupId;
  final String tenantId;
  final String phoneNumber;
  final String lastSignInAt;
  final List<String> permissions;
  final List<dynamic> provinces;
  final List<District> districts;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.status,
    required this.permissionGroupId,
    required this.tenantId,
    required this.phoneNumber,
    required this.lastSignInAt,
    required this.permissions,
    required this.provinces,
    required this.districts,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
      permissionGroupId: json['permissionGroupId'],
      tenantId: json['tenantId'],
      phoneNumber: json['phoneNumber'],
      lastSignInAt: json['lastSignInAt'],
      permissions: List<String>.from(json['permissions']),
      provinces: json['provinces'], // You can define a Province model if needed
      districts: (json['districts'] as List<dynamic>)
          .map((e) => District.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'role': role,
      'status': status,
      'permissionGroupId': permissionGroupId,
      'tenantId': tenantId,
      'phoneNumber': phoneNumber,
      'lastSignInAt': lastSignInAt,
      'permissions': permissions,
      'provinces': provinces,
      'districts': districts.map((e) => e.toJson()).toList(),
    };
  }
}
