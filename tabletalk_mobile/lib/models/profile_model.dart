class UserProfile {
  String id;
  String accountId;
  String fullName;
  String email;
  String? phone;
  String? address;
  String? nationality;
  String? country;
  String? bio;
  String? favoriteMeals;
  String? hateMeals;
  String? eatingHabits;
  String membership;
  String searchCount;

  UserProfile({
    required this.id,
    required this.accountId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.nationality,
    required this.country,
    required this.bio,
    required this.favoriteMeals,
    required this.hateMeals,
    required this.eatingHabits,
    required this.membership,
    required this.searchCount,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    var profile = json['profile'] ?? {};
    return UserProfile(
      id: profile['id'] ?? '',
      accountId: profile['accountId'] ?? '',
      fullName: profile['fullName'] ?? '',
      email: profile['email'] ?? '',
      phone: profile['phone'],
      address: profile['address'],
      nationality: profile['nationality'],
      country: profile['country'],
      bio: profile['bio'],
      favoriteMeals: profile['favoriteMeals'],
      hateMeals: profile['hateMeals'],
      eatingHabits: profile['eatingHabits'].toString(),
      membership: profile['membership'] ?? 'normal',
      searchCount: profile['searchCount'].toString(),
    );
  }
}
