class SearchIdModel {
  final String id;

  SearchIdModel({
    required this.id,
  });

  factory SearchIdModel.fromJson(Map<String, dynamic> json) {
    return SearchIdModel(
      id: json['id'] ?? '',
    );
  }
}
