import 'ListingModel.dart';

class ListingResponse {
  final List<ListingModel> data;
  final int currentPage;
  final int lastPage;
  final int totalItem;

  ListingResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.totalItem,
  });

  factory ListingResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['data'] as List;
    return ListingResponse(
      data: rawList.map((e) => ListingModel.fromJson(e)).toList(),
      currentPage: json['currentPage'],
      lastPage: json['lastPage'],
      totalItem: json['totalItem'],
    );
  }
}

