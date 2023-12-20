class SearchHistoryModel {
  final String id;
  final String searchText;
  final String time;

  SearchHistoryModel({
    required this.id,
    required this.searchText,
    required this.time,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
        id: json['id'] ?? '',
        searchText: json['searchText'] ?? '',
        time: json['createdAt'] ?? '');
  }
}
//5f3ce52d-ac07-4f49-bc7e-c3487b7be8dc
//5f3ce52d-ac07-4f49-bc7e-c3487b7be8dc
//id == searchId