class SearchHistoryModel {
  final String searchId;
  final String searchText;
  final String time;

  SearchHistoryModel({
    required this.searchId,
    required this.searchText,
    required this.time,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
        searchId: json['id'] ?? '',
        searchText: json['searchText'] ?? '',
        time: json['time'] ?? '');
  }
}
