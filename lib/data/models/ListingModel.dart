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
    required super.realEstateType,
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
    required super.facing,
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
      streetName: json['streetName'],
      fullAddress: json['fullAddress'],
      latitude: _parseToDouble(json['latitude']),
      longitude: _parseToDouble(json['longitude']),
      commissionRatePercent: json['commissionRatePercent'],
      commissionAmountVnd: json['commissionAmountVnd'] as int?,
      legalAreaSqm: json['legalAreaSqm'],
      actualAreaSqm: json['actualAreaSqm'],
      frontageMeters: json['frontageMeters'],
      widthMeters: json['widthMeters'],
      roadWidthMeters: json['roadWidthMeters'] as int?,
      numberOfFloors: json['numberOfFloors'] as int? ?? 0,

      realEstateType: json['realEstateType'],
      createdBy: json['createdBy'],
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now(),
      updatedAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
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
      likes: json['likes'] as int? ?? 0,
      phoneNumber: json['phoneNumber'],
      ownerPhoneNumber: json['ownerPhoneNumber'],
      ownerCitizenId: json['ownerCitizenId'],
      numberOfRooms: json['numberOfRooms'] as int? ?? 0,
      numberOfBathrooms: json['numberOfBathrooms'] as int? ?? 0,
      numberOfBalconies: json['numberOfBalconies'] as int?,
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
      updatedBy: json['updatedBy'],
      listingPriceVndSell: json['listingPriceVndSell'],
      listingPriceVndRent: json['listingPriceVndRent'],
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

      'realEstateType': realEstateType,
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
    };
  }

  static double? _parseToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
