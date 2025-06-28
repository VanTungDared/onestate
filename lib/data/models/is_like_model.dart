import 'package:app_real_estate/domain/entities/is_like.dart';

class IsLikeModel extends IsLiked {
  IsLikeModel({
    required super.id,
    required super.userId,
    required super.listingId,
    required super.createdAt,
  });

  factory IsLikeModel.fromJson(Map<String, dynamic> json) {
    return IsLikeModel(
      id: json['id'],
      userId: json['userId'],
      listingId: json['listingId'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'listingId': listingId,
      'createdAt': createdAt,
    };
  }
}
