import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/recipe_detail.dart';
import 'dart:convert';

class RecipeDataService {
  final String accessToken;
  RecipeDataService({required this.accessToken});

  Future<RecipeDetail> fetchRecipeDetails(String recipeId) async {
    final response = await http.get(
      Uri.parse('https://api.amzegy.com/core/api/v1/search/recipes/$recipeId'),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      RecipeDetail recipeDetail = RecipeDetail.fromJson(jsonData);
      return recipeDetail;
    } else {
      throw Exception(
          'Failed to load data. Error code: ${response.statusCode}');
    }
  }
}
