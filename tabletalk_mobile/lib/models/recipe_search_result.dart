class RecipeSearchResult {
  final String id;
  final String name;
  final String author;
  final int time;
  final String imageUrl;
  final String reason;

  RecipeSearchResult({
    required this.id,
    required this.name,
    required this.author,
    required this.time,
    required this.imageUrl,
    required this.reason,
  });

  factory RecipeSearchResult.fromJson(Map<String, dynamic> json) {
    return RecipeSearchResult(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      author: json['author'] ?? '',
      time: json['time'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      reason: json['reason'] ?? '',
    );
  }
}
