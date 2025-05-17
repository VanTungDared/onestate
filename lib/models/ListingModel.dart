class LandCertificate {
  final String code;
  final List<String> imageUrls;

  LandCertificate({required this.code, required this.imageUrls});

  factory LandCertificate.fromJson(Map<String, dynamic> json) {
    return LandCertificate(
      code: json['code'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'imageUrls': imageUrls};
  }
}

class ListingModel {
  final String id;
  final String title;
  final String status;
  final String description;
  final String ownerName;
  final String provinceCode;
  final String districtCode;
  final String wardCode;
  final String? streetName;
  final String? fullAddress;
  final double? latitude;
  final double? longitude;
  final String commissionRatePercent;
  final String commissionAmountVnd;
  final String legalAreaSqm;
  final String actualAreaSqm;
  final String frontageMeters;
  final String? widthMeters;
  final String? roadWidthMeters;
  final int? numberOfFloors;
  final String listingPriceVnd;
  final String realEstateType;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String authorName;
  final List<String> imageUrls;
  final List<String> tags;
  final String? province;
  final String? district;
  final String? ward;

  // New fields
  final int? likes;
  final String? phoneNumber;
  final String? ownerPhoneNumber;
  final String? ownerCitizenId;
  final int? numberOfRooms;
  final int? numberOfBathrooms;
  final int? numberOfBalconies;
  final String? facing;
  final LandCertificate? landCertificate;

  ListingModel({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.ownerName,
    required this.provinceCode,
    required this.districtCode,
    required this.wardCode,
    this.streetName,
    this.fullAddress,
    this.latitude,
    this.longitude,
    required this.commissionRatePercent,
    required this.commissionAmountVnd,
    required this.legalAreaSqm,
    required this.actualAreaSqm,
    required this.frontageMeters,
    this.widthMeters,
    this.roadWidthMeters,
    this.numberOfFloors,
    required this.listingPriceVnd,
    required this.realEstateType,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.authorName,
    required this.imageUrls,
    required this.tags,
    this.province,
    this.district,
    this.ward,
    this.likes,
    this.phoneNumber,
    this.ownerPhoneNumber,
    this.ownerCitizenId,
    this.numberOfRooms,
    this.numberOfBathrooms,
    this.numberOfBalconies,
    this.facing,
    this.landCertificate,
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
      latitude:
          json['latitude'] != null
              ? (json['latitude'] as num).toDouble()
              : null,
      longitude:
          json['longitude'] != null
              ? (json['longitude'] as num).toDouble()
              : null,
      commissionRatePercent: json['commissionRatePercent'],
      commissionAmountVnd: json['commissionAmountVnd'],
      legalAreaSqm: json['legalAreaSqm'],
      actualAreaSqm: json['actualAreaSqm'],
      frontageMeters: json['frontageMeters'],
      widthMeters: json['widthMeters'],
      roadWidthMeters: json['roadWidthMeters'],
      numberOfFloors: json['numberOfFloors'],
      listingPriceVnd: json['listingPriceVnd'],
      realEstateType: json['realEstateType'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      authorName: json['authorName'],
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      province: json['province']?['name'],
      district: json['district']?['name'],
      ward: json['ward']?['name'],
      likes: json['likes'],
      phoneNumber: json['phoneNumber'],
      ownerPhoneNumber: json['ownerPhoneNumber'],
      ownerCitizenId: json['ownerCitizenId'],
      numberOfRooms: json['numberOfRooms'],
      numberOfBathrooms: json['numberOfBathrooms'],
      numberOfBalconies: json['numberOfBalconies'],
      facing: json['facing'],
      landCertificate:
          json['landCertificate'] != null
              ? LandCertificate.fromJson(json['landCertificate'])
              : null,
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
      'listingPriceVnd': listingPriceVnd,
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
      'landCertificate': landCertificate?.toJson(),
    };
  }
}
