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
}
