import 'package:app_real_estate/domain/entities/district.dart';

import '../../domain/entities/landcertificate.dart';
import '../../domain/entities/listing.dart';
import 'district_model.dart';
import 'landcertificate.dart';

class ListingModel extends Listing {
  ListingModel({
    required super.id,
    required super.title,
    required super.status,
    required super.description,
    required super.ownerName,
    required super.provinceCode,
    required super.districtCode,
    required super.wardCode,
    required super.streetName,
    required super.fullAddress,
    super.latitude,
    super.longitude,
    required super.commissionRatePercent,
    super.commissionAmountVnd,
    required super.legalAreaSqm,
    required super.actualAreaSqm,
    required super.frontageMeters,
    required super.widthMeters,
    super.roadWidthMeters,
    required super.numberOfFloors,
    required super.createdBy,
    required super.createdAt,
    required super.updatedAt,
    required super.authorName,
    required super.imageUrls,
    required super.tags,
    required super.province,
    required super.district,
    super.ward,
    required super.likes,
    required super.phoneNumber,
    required super.ownerPhoneNumber,
    required super.ownerCitizenId,
    required super.numberOfRooms,
    required super.numberOfBathrooms,
    required super.numberOfBalconies,
    super.facing,
    super.landCertificate,
    required super.updatedBy,
    required super.listingPriceVndSell,
    required super.listingPriceVndRent,
    required super.listingCode,
    required super.listingType,
    required super.isLiked,
    required super.propertyType,
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    return ListingModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      description: json['description'],
      ownerName: json['ownerName'],
      provinceCode: json['provinceCode'],
      districtCode: json['districtCode'],
      wardCode: json['wardCode'],
      streetName: json['streetName'] ?? "",
      fullAddress: json['fullAddress'] ?? "",
      latitude: _parseToDouble(json['latitude']),
      longitude: _parseToDouble(json['longitude']),
      commissionRatePercent: _parseToDouble(json['commissionRatePercent']) ?? 0,
      commissionAmountVnd: _parseToInt(json['commissionAmountVnd']),
      legalAreaSqm: _parseToDouble(json['legalAreaSqm']) ?? 0,
      actualAreaSqm: _parseToDouble(json['actualAreaSqm']) ?? 0,
      frontageMeters: _parseToDouble(json['frontageMeters']) ?? 0,
      widthMeters: _parseToDouble(json['widthMeters']) ?? 0,
      roadWidthMeters: _parseToDouble(json['roadWidthMeters']),
      numberOfFloors: _parseToInt(json['numberOfFloors']) ?? 0,

      createdBy: json['createdBy'],
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now(),
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.parse(json['updatedAt'])
              : DateTime.now(),
      authorName: json['authorName'],
      imageUrls:
          (json['imageUrls'] as List?)?.map((e) => e.toString()).toList() ?? [],
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      province:
          json['province'] != null
              ? DistrictModel.fromJson(json['province'])
              : District(code: "", name: ""),
      district:
          json['district'] != null
              ? DistrictModel.fromJson(json['district'])
              : District(code: "", name: ""),
      ward: json['ward']?['name'],
      likes: _parseToInt(json['likes']) ?? 0,
      phoneNumber: json['phoneNumber'],
      ownerPhoneNumber: json['ownerPhoneNumber'],
      ownerCitizenId: json['ownerCitizenId'],
      numberOfRooms: _parseToInt(json['numberOfRooms']) ?? 0,
      numberOfBathrooms: _parseToInt(json['numberOfBathrooms']) ?? 0,
      numberOfBalconies: _parseToInt(json['numberOfBalconies']),
      facing: json['facing'],
      landCertificate:
          json['landCertificate'] != null
              ? LandCertificate(
                code: json['landCertificate']['code'] ?? '',
                imageUrls:
                    (json['landCertificate']['imageUrls'] as List?)
                        ?.map((e) => e.toString())
                        .toList() ??
                    [],
              )
              : null,
      updatedBy: json['updatedBy'] ?? "",
      listingPriceVndSell: _parseToDouble(json['listingPriceVndSell']) ?? 0,
      listingPriceVndRent: _parseToDouble(json['listingPriceVndRent']),
      listingCode: json['listingCode'],
      listingType: json['listingType'],
      isLiked: json['isLiked'] as bool? ?? false,
      propertyType: json['propertyType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'description': description,
      'ownerName': ownerName,
      'provinceCode': provinceCode,
      'districtCode': districtCode,
      'wardCode': wardCode,
      'streetName': streetName,
      'fullAddress': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'commissionRatePercent': commissionRatePercent,
      'commissionAmountVnd': commissionAmountVnd,
      'legalAreaSqm': legalAreaSqm,
      'actualAreaSqm': actualAreaSqm,
      'frontageMeters': frontageMeters,
      'widthMeters': widthMeters,
      'roadWidthMeters': roadWidthMeters,
      'numberOfFloors': numberOfFloors,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'authorName': authorName,
      'imageUrls': imageUrls,
      'tags': tags,
      'province': province,
      'district': district,
      'ward': ward,
      'likes': likes,
      'phoneNumber': phoneNumber,
      'ownerPhoneNumber': ownerPhoneNumber,
      'ownerCitizenId': ownerCitizenId,
      'numberOfRooms': numberOfRooms,
      'numberOfBathrooms': numberOfBathrooms,
      'numberOfBalconies': numberOfBalconies,
      'facing': facing,
      'landCertificate':
          landCertificate is LandCertificateModel
              ? (landCertificate as LandCertificateModel).toJson()
              : null,
      'updatedBy': updatedBy,
      'listingPriceVndSell': listingPriceVndSell,
      'listingPriceVndRent': listingPriceVndRent,
      'listingCode': listingCode,
      'listingType': listingType,
      'isLiked': isLiked,
      'propertyType': propertyType,
    };
  }

  static double? _parseToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
