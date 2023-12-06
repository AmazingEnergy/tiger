class RestaurantDetail {
  final String id;
  final String name;
  final double rating;
  final String address;
  final String imageUrl;
  final String mapUrl;
  final String website;

  const RestaurantDetail({
    required this.id,
    required this.name,
    required this.rating,
    required this.address,
    required this.imageUrl,
    required this.mapUrl,
    required this.website,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      rating: json['rating'] != null
          ? double.parse(json['rating'].toString())
          : 0.0,
      address: json['address'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      mapUrl: json['mapUrl'] ?? '',
      website: json['website'] ?? '',
    );
  }
}
