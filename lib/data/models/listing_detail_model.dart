import 'package:app_real_estate/data/models/is_like_model.dart';
import 'package:app_real_estate/domain/entities/is_like.dart';
import 'package:app_real_estate/domain/entities/listing_detail.dart';

import '../../domain/entities/district.dart';
import 'district_model.dart';

class ListingDetailModel extends ListingDetail {
  ListingDetailModel({
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
    required super.latitude,
    required super.longitude,
    required super.commissionRatePercent,
    required super.commissionAmountVnd,
    required super.legalAreaSqm,
    required super.actualAreaSqm,
    required super.frontageMeters,
    required super.widthMeters,
    required super.roadWidthMeters,
    required super.numberOfFloors,
    required super.listingPriceVndSell,
    required super.listingPriceVndRent,
    required super.realEstateType,
    required super.createdBy,
    required super.updatedBy,
    required super.createdAt,
    required super.updatedAt,
    required super.authorName,
    required super.phoneNumber,
    required super.imageUrls,
    required super.tags,
    required super.propertyType,
    required super.province,
    required super.district,
    required super.ward,
    required super.likes,
    required super.ownerPhoneNumber,
    required super.ownerCitizenId,
    required super.numberOfRooms,
    required super.numberOfBathrooms,
    required super.numberOfBalconies,
    required super.facing,
    required super.landCertificate,
    required super.listingCode,
    required super.listingType,
    required super.isLiked,
  });

  factory ListingDetailModel.fromJson(Map<String, dynamic> json) {
    return ListingDetailModel(
      id: json['id'] ?? '',
      title: json['title'],
      status: json['status'],
      description: json['description'],
      ownerName: json['ownerName'],
      provinceCode: json['provinceCode'],
      districtCode: json['districtCode'],
      wardCode: json['wardCode'],
      streetName: json['streetName'],
      fullAddress: json['fullAddress'],
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      commissionRatePercent: json['commissionRatePercent'],
      commissionAmountVnd: json['commissionAmountVnd'],
      legalAreaSqm: json['legalAreaSqm'],
      actualAreaSqm: json['actualAreaSqm'],
      frontageMeters: json['frontageMeters'],
      widthMeters: json['widthMeters'],
      roadWidthMeters: (json['roadWidthMeters'] as num?)?.toDouble(),
      numberOfFloors: json['numberOfFloors'],
      realEstateType: json['realEstateType'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now(),
      updatedAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now(),
      authorName: json['authorName'],
      phoneNumber: json['phoneNumber'],
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
      ward:
          json['ward'] != null
              ? DistrictModel.fromJson(json['ward'])
              : District(code: "", name: ""),
      likes: json['likes'],
      isLiked:
          json['isLiked'] != null
              ? IsLikeModel.fromJson(json['isLiked'])
              : IsLiked(
                id: '',
                userId: '',
                listingId: '',
                createdAt: DateTime.now(),
              ),
      ownerPhoneNumber: json['ownerPhoneNumber'],
      ownerCitizenId: json['ownerCitizenId'],
      numberOfRooms: json['numberOfRooms'],
      numberOfBathrooms: json['numberOfBathrooms'],
      numberOfBalconies: json['numberOfBalconies'],
      facing: json['facing'],
      landCertificate: json['landCertificate'],
      listingPriceVndSell: json['listingPriceVndSell'],
      listingPriceVndRent: json['listingPriceVndRent'],
      propertyType: json['propertyType'],
      listingCode: json['listingCode'],
      listingType: json['listingType'],
    );
  }

  Map<String, dynamic> toJson() => {
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
    'updatedBy': updatedBy,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'authorName': authorName,
    'phoneNumber': phoneNumber,
    'imageUrls': imageUrls,
    'tags': tags,
    'province': province,
    'district': district,
    'ward': ward,
    'likes': likes,
    'isLiked': isLiked,
    'ownerPhoneNumber': ownerPhoneNumber,
    'ownerCitizenId': ownerCitizenId,
    'numberOfRooms': numberOfRooms,
    'numberOfBathrooms': numberOfBathrooms,
    'numberOfBalconies': numberOfBalconies,
    'facing': facing,
    'landCertificate': landCertificate,
  };
}
