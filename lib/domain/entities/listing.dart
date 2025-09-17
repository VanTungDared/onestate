import 'district.dart';

class Listing {
  String id;
  String title;
  String status;
  String description;
  String ownerName;
  String provinceCode;
  String districtCode;
  String wardCode;
  String streetName;
  String fullAddress;
  double? latitude;
  double? longitude;

  double commissionRatePercent; // trước là String
  int? commissionAmountVnd; // giữ int
  double legalAreaSqm; // trước là String
  double actualAreaSqm; // trước là String
  double frontageMeters; // trước là String
  double widthMeters; // trước là String
  double? roadWidthMeters;

  int numberOfFloors;
  double listingPriceVndSell; // trước là String
  double? listingPriceVndRent; // trước là String?

  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  String authorName;
  String phoneNumber;

  List<String> imageUrls;
  List<String> tags;
  String propertyType;

  District province;
  District district;
  dynamic ward; // có thể là object hoặc null

  int likes;
  String ownerPhoneNumber;
  String ownerCitizenId;
  int numberOfRooms;
  int numberOfBathrooms;
  int? numberOfBalconies;
  String? facing;

  dynamic landCertificate;
  String listingCode;
  String listingType;
  bool isLiked;

  Listing({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.ownerName,
    required this.provinceCode,
    required this.districtCode,
    required this.wardCode,
    required this.streetName,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    required this.commissionRatePercent,
    required this.commissionAmountVnd,
    required this.legalAreaSqm,
    required this.actualAreaSqm,
    required this.frontageMeters,
    required this.widthMeters,
    required this.roadWidthMeters,
    required this.numberOfFloors,
    required this.listingPriceVndSell,
    required this.listingPriceVndRent,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.authorName,
    required this.phoneNumber,
    required this.imageUrls,
    required this.tags,
    required this.propertyType,
    required this.province,
    required this.district,
    required this.ward,
    required this.likes,
    required this.ownerPhoneNumber,
    required this.ownerCitizenId,
    required this.numberOfRooms,
    required this.numberOfBathrooms,
    required this.numberOfBalconies,
    required this.facing,
    required this.landCertificate,
    required this.listingCode,
    required this.listingType,
    required this.isLiked,
  });
}
