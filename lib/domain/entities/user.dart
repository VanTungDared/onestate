import 'district.dart';

class User {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String status;
  final String? permissionGroupId;
  final String tenantId;
  final String phoneNumber;
  final String lastSignInAt;
  final String? section;
  final List<String> permissions;
  final List<dynamic> provinces;
  final List<District> districts;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.status,
    required this.permissionGroupId,
    required this.tenantId,
    required this.phoneNumber,
    required this.lastSignInAt,
    required this.section,
    required this.permissions,
    required this.provinces,
    required this.districts,
  });
}
