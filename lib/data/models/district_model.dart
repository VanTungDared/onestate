import '../../domain/entities/district.dart';

class DistrictModel extends District {
  DistrictModel({required super.code, required super.name});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(code: json['code'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name};
  }
}
