class RecipeSearchResult {
  final String id;
  final String name;
  final int time;
  final String author;
  final String imageUrl;
  final String reason;

  RecipeSearchResult({
    required this.id,
    required this.name,
    required this.time,
    required this.imageUrl,
    required this.reason,
    required this.author,
  });

  factory RecipeSearchResult.fromJson(Map<String, dynamic> json) {
    return RecipeSearchResult(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        time: json['time'] ?? 0,
        imageUrl: json['imageUrl'] ?? '',
        reason: json['reason'] ?? '',
        author: json['author'] ?? '');
  }
}
