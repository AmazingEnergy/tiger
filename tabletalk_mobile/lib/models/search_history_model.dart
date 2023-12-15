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
