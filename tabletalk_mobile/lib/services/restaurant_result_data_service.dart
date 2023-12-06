import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tabletalk_mobile/models/restaurant_search_result.dart';

class RestaurantSearchService {
  final String accessToken;
  RestaurantSearchService({required this.accessToken});

  Future<List<RestaurantSearchResult>> fetchRestaurantSearchResults(
      String searchId) async {
    final response = await http.get(
      Uri.parse(
          'https://api.amzegy.com/core/api/v1/search/$searchId/restaurants?latitude=10.740710811318294&longitude=106.7361430233963'),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      List<dynamic> items = jsonData['items'];

      List<RestaurantSearchResult> searchResults = items.map((data) {
        return RestaurantSearchResult.fromJson(data);
      }).toList();

      return searchResults;
    } else {
      throw Exception(
          'Failed to load data. Error code: ${response.statusCode}');
    }
  }
}
