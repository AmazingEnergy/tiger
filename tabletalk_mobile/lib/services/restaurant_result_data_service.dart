import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tabletalk_mobile/models/restaurant_search_result.dart';

class RestaurantSearchService {
  Future<List<RestaurantSearchResult>> fetchRestaurantSearchResults() async {
    final response = await http.get(Uri.parse('https://'));

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
