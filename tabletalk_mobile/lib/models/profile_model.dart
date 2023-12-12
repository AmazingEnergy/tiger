class UserProfile {
  String id;
  String imageUrl;
  String email;
  String fullName;
  String address;
  String nationality;
  String bio;
  String favoriteMeals;
  String hateMeals;
  int eatingHabit;

  UserProfile({
    required this.id,
    required this.imageUrl,
    required this.email,
    required this.fullName,
    required this.address,
    required this.nationality,
    required this.bio,
    required this.favoriteMeals,
    required this.hateMeals,
    required this.eatingHabit,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      fullName: json['fullName'] ?? '',
      address: json['address'] ?? '',
      nationality: json['nationality'] ?? '',
      bio: json['bio'] ?? '',
      favoriteMeals: json['favoriteMeals'] ?? '',
      hateMeals: json['hateMeals'] ?? '',
      eatingHabit: int.tryParse(json['eatingHabit'].toString()) ?? 0,
      email: json['email'] ?? '',
    );
  }

  get imageFile => null;
}
