class ListingDetailModel {
  final String id;
  final String title;
  final String status;
  final String description;
  final String ownerName;
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
  final String? numberOfFloors;
  final String listingPriceVnd;
  final String realEstateType;
  final String authorName;
  final String phoneNumber;
  final List<String> imageUrls;
  final List<String> tags;
  final Province province;
  final District district;
  final Ward ward;
  final int likes;

  ListingDetailModel({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.ownerName,
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
    required this.authorName,
    required this.phoneNumber,
    required this.imageUrls,
    required this.tags,
    required this.province,
    required this.district,
    required this.ward,
    required this.likes,
  });

  factory ListingDetailModel.fromJson(Map<String, dynamic> json) {
    return ListingDetailModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      description: json['description'],
      ownerName: json['ownerName'],
      streetName: json['streetName'],
      fullAddress: json['fullAddress'],
      latitude:
          json['latitude'] != null
              ? double.tryParse(json['latitude'].toString())
              : null,
      longitude:
          json['longitude'] != null
              ? double.tryParse(json['longitude'].toString())
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
      authorName: json['authorName'],
      phoneNumber: json['phoneNumber'],
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      province: Province.fromJson(json['province']),
      district: District.fromJson(json['district']),
      ward: Ward.fromJson(json['ward']),
      likes: json['likes'] ?? 0,
    );
  }
}

class Province {
  final String code;
  final String name;

  Province({required this.code, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(code: json['code'], name: json['name']);
  }
}

class District {
  final String code;
  final String name;

  District({required this.code, required this.name});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(code: json['code'], name: json['name']);
  }
}

class Ward {
  final String code;
  final String name;

  Ward({required this.code, required this.name});

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(code: json['code'], name: json['name']);
  }
}
