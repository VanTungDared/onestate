import 'package:app_real_estate/domain/entities/provinces.dart';

class ProvincesModel extends Provinces {
  ProvincesModel({required super.code, required super.fullName});

  factory ProvincesModel.fromJson(Map<String, dynamic> json) {
    return ProvincesModel(code: json['code'], fullName: json['fullName']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'fullName': fullName};
  }
}
