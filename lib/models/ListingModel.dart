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
  final String updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String authorName;
  final List<String> imageUrls;
  final List<String> tags;
  final String? province;
  final String? district;
  final String? ward;

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
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.authorName,
    required this.imageUrls,
    required this.tags,
    this.province,
    this.district,
    this.ward,
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
      updatedBy: json['updatedBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      authorName: json['authorName'],
      imageUrls: List<String>.from(json['imageUrls']),
      tags: List<String>.from(json['tags']),
      province: json['province'],
      district: json['district'],
      ward: json['ward'],
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
      'updatedBy': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'authorName': authorName,
      'imageUrls': imageUrls,
      'tags': tags,
      'province': province,
      'district': district,
      'ward': ward,
    };
  }
}
