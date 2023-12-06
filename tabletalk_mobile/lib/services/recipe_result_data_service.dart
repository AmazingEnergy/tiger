import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/recipe_search_result.dart';

class RecipeSearchService {
  final String accessToken;
  RecipeSearchService({required this.accessToken});

  Future<List<RecipeSearchResult>> fetchRecipeSearchResults(
      String searchId) async {
    //50a4ce4a-7c2f-4a2f-88c1-314f0cc0551a
    print("fetching recipes");
    final response = await http.get(
      Uri.parse(
        'https://api.amzegy.com/core/api/v1/search/$searchId/recipes',
      ),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      List<RecipeSearchResult> searchResults = [];

      List<dynamic> items = jsonData['items'];

      for (var item in items) {
        searchResults.add(RecipeSearchResult.fromJson(item));
      }

      return searchResults;
    } else {
      throw Exception(
        'Failed to load data. Error code: ${response.statusCode}',
      );
    }
  }
}
