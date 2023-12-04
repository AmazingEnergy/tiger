class RestaurantSearchResult {
  final String id;
  final String name;
  final double rating;
  final String imageUrl;
  final String reason;

  RestaurantSearchResult({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
    required this.reason,
  });

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) {
    return RestaurantSearchResult(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      rating: json['rating'] != null
          ? double.parse(json['rating'].toString())
          : 0.0,
      imageUrl: json['imageUrl'] ?? '',
      reason: json['reason'] ?? '',
    );
  }
}
