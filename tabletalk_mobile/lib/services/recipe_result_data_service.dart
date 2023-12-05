import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/recipe_search_result.dart';

class RecipeSearchResultDataService {
  final String accessToken;
  final String id;
  RecipeSearchResultDataService({required this.accessToken, required this.id});

  Future<List<RecipeSearchResult>> fetchRecipeSearchResults() async {
    final response = await http.get(
        Uri.parse('https://api.amzegy.com/core/api/v1/search/$id/recipes'),
        headers: {"Authentication": accessToken});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      List<dynamic> items = jsonData['items'];

      List<RecipeSearchResult> searchResults = items.map((data) {
        return RecipeSearchResult.fromJson(data);
      }).toList();

      return searchResults;
    } else {
      throw Exception(
          'Failed to load data. Error code: ${response.statusCode}');
    }
  }
}
