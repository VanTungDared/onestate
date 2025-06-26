
import '../../data/models/ListingModel.dart';
import 'landcertificate.dart';

class Listing {
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
  final String? commissionAmountVnd;
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

  final int? likes;
  final String? phoneNumber;
  final String? ownerPhoneNumber;
  final String? ownerCitizenId;
  final int? numberOfRooms;
  final int? numberOfBathrooms;
  final int? numberOfBalconies;
  final String? facing;
  final LandCertificate? landCertificate;

  final String updatedBy;
  final String listingPriceVndSell;
  final dynamic listingPriceVndRent;
  final String listingCode;
  final String listingType;
  final bool isLiked;

  Listing({
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
    this.commissionAmountVnd,
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
    required this.updatedBy,
    required this.listingPriceVndSell,
    required this.listingPriceVndRent,
    required this.listingCode,
    required this.listingType,
    required this.isLiked,
  });
}


