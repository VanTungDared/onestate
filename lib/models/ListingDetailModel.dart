class ListingDetailModel {
  final String id;
  final String? title;
  final String? status;
  final String? description;
  final String? ownerName;
  final String? provinceCode;
  final String? districtCode;
  final String? wardCode;
  final String? streetName;
  final String? fullAddress;
  final double? latitude;
  final double? longitude;
  final String? commissionRatePercent;
  final String? commissionAmountVnd;
  final String? legalAreaSqm;
  final String? actualAreaSqm;
  final String? frontageMeters;
  final String? widthMeters;
  final double? roadWidthMeters;
  final int? numberOfFloors;
  final String? listingPriceVnd;
  final String? realEstateType;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? authorName;
  final String? phoneNumber;
  final List<String>? imageUrls;
  final List<String>? tags;
  final LocationUnit? province;
  final LocationUnit? district;
  final LocationUnit? ward;
  final int? likes;
  final String? ownerPhoneNumber;
  final String? ownerCitizenId;
  final int? numberOfRooms;
  final int? numberOfBathrooms;
  final int? numberOfBalconies;
  final String? facing;
  final String? landCertificate;

  ListingDetailModel({
    required this.id,
    this.title,
    this.status,
    this.description,
    this.ownerName,
    this.provinceCode,
    this.districtCode,
    this.wardCode,
    this.streetName,
    this.fullAddress,
    this.latitude,
    this.longitude,
    this.commissionRatePercent,
    this.commissionAmountVnd,
    this.legalAreaSqm,
    this.actualAreaSqm,
    this.frontageMeters,
    this.widthMeters,
    this.roadWidthMeters,
    this.numberOfFloors,
    this.listingPriceVnd,
    this.realEstateType,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.authorName,
    this.phoneNumber,
    this.imageUrls,
    this.tags,
    this.province,
    this.district,
    this.ward,
    this.likes,
    this.ownerPhoneNumber,
    this.ownerCitizenId,
    this.numberOfRooms,
    this.numberOfBathrooms,
    this.numberOfBalconies,
    this.facing,
    this.landCertificate,
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
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      commissionRatePercent: json['commissionRatePercent'],
      commissionAmountVnd: json['commissionAmountVnd'],
      legalAreaSqm: json['legalAreaSqm'],
      actualAreaSqm: json['actualAreaSqm'],
      frontageMeters: json['frontageMeters'],
      widthMeters: json['widthMeters'],
      roadWidthMeters: (json['roadWidthMeters'] as num?)?.toDouble(),
      numberOfFloors: json['numberOfFloors'],
      listingPriceVnd: json['listingPriceVnd'],
      realEstateType: json['realEstateType'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      authorName: json['authorName'],
      phoneNumber: json['phoneNumber'],
      imageUrls:
          (json['imageUrls'] as List?)?.map((e) => e.toString()).toList(),
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList(),
      province:
          json['province'] != null
              ? LocationUnit.fromJson(json['province'])
              : null,
      district:
          json['district'] != null
              ? LocationUnit.fromJson(json['district'])
              : null,
      ward: json['ward'] != null ? LocationUnit.fromJson(json['ward']) : null,
      likes: json['likes'],
      ownerPhoneNumber: json['ownerPhoneNumber'],
      ownerCitizenId: json['ownerCitizenId'],
      numberOfRooms: json['numberOfRooms'],
      numberOfBathrooms: json['numberOfBathrooms'],
      numberOfBalconies: json['numberOfBalconies'],
      facing: json['facing'],
      landCertificate: json['landCertificate'],
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
    'listingPriceVnd': listingPriceVnd,
    'realEstateType': realEstateType,
    'createdBy': createdBy,
    'updatedBy': updatedBy,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'authorName': authorName,
    'phoneNumber': phoneNumber,
    'imageUrls': imageUrls,
    'tags': tags,
    'province': province?.toJson(),
    'district': district?.toJson(),
    'ward': ward?.toJson(),
    'likes': likes,
    'ownerPhoneNumber': ownerPhoneNumber,
    'ownerCitizenId': ownerCitizenId,
    'numberOfRooms': numberOfRooms,
    'numberOfBathrooms': numberOfBathrooms,
    'numberOfBalconies': numberOfBalconies,
    'facing': facing,
    'landCertificate': landCertificate,
  };
}

class LocationUnit {
  final String code;
  final String name;

  LocationUnit({required this.code, required this.name});

  factory LocationUnit.fromJson(Map<String, dynamic> json) {
    return LocationUnit(code: json['code'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'code': code, 'name': name};
}
