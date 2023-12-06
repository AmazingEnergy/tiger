import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/restaurant_detail.dart';
import 'dart:convert';

class RestaurantDataService {
  final String accessToken;

  RestaurantDataService({required this.accessToken});

  Future<RestaurantDetail> fetchRestaurantDetails(String restaurantId) async {
    final response = await http.get(
      Uri.parse(
          'https://api.amzegy.com/core/api/v1/search/restaurants/$restaurantId'),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      RestaurantDetail restaurantDetail = RestaurantDetail.fromJson(jsonData);
      return restaurantDetail;
    } else {
      throw Exception(
          'Failed to load data. Error code: ${response.statusCode}');
    }
  }
}
