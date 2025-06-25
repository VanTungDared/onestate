import '../../domain/entities/user.dart';
import 'district_model.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.role,
    required super.status,
    required super.permissionGroupId,
    required super.tenantId,
    required super.phoneNumber,
    required super.lastSignInAt,
    required super.section,
    required super.permissions,
    required super.provinces,
    required super.districts,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      permissionGroupId: json['permissionGroupId']?.toString(),
      tenantId: json['tenantId'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      lastSignInAt: json['lastSignInAt'] ?? '',
      section: json['section']?.toString(),
      permissions: List<String>.from(json['permissions'] ?? []),
      provinces: json['provinces'] ?? [],
      districts:
          (json['districts'] as List<dynamic>? ?? [])
              .map((e) => DistrictModel.fromJson(e))
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
      'section': section,
      'permissions': permissions,
      'provinces': provinces,
      'districts': districts.map((e) => (e as DistrictModel).toJson()).toList(),
    };
  }
}
