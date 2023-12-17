import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/profile_model.dart';
import 'dart:convert';

class UserProfileService {
  final String accessToken;

  UserProfileService({required this.accessToken});

  Future<UserProfile> getProfile() async {
    final response = await http.get(
      Uri.parse('https://api.amzegy.com/core/api/v1/accounts/me'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return UserProfile.fromJson(jsonData);
    } else {
      throw Exception(
          'Failed to load user profile. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateProfile(String id, UserProfile updatedProfile) async {
    int? eatingHabitsNumber;

    try {
      if (updatedProfile.eatingHabits != null) {
        eatingHabitsNumber = int.parse(updatedProfile.eatingHabits!);
      }
    } catch (e) {
      throw Exception('Eating habits must be a valid number');
    }

    final response = await http.put(
      Uri.parse('https://api.amzegy.com/core/api/v1/customers/$id'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
      body: json.encode({
        "fullName": updatedProfile.fullName,
        "address": updatedProfile.address,
        "phone": updatedProfile.phone ?? '0',
        "nationality": updatedProfile.nationality,
        "country": updatedProfile.country,
        "bio": updatedProfile.bio,
        "favoriteMeals": updatedProfile.favoriteMeals,
        "hateMeals": updatedProfile.hateMeals,
        "eatingHabits": eatingHabitsNumber,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to update user profile. Status code: ${response.body}');
    }
  }
}
