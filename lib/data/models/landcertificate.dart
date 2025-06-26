import '../../domain/entities/landcertificate.dart';

class LandCertificateModel extends LandCertificate {
  LandCertificateModel({required super.code, required super.imageUrls});

  factory LandCertificateModel.fromJson(Map<String, dynamic> json) {
    return LandCertificateModel(
      code: json['code'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'imageUrls': imageUrls};
  }
}
