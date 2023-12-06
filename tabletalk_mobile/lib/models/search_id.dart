class SearchId {
  final String id;

  SearchId({
    required this.id,
  });

  factory SearchId.fromJson(Map<String, dynamic> json) {
    return SearchId(
      id: json['id'] ?? '',
    );
  }
}
