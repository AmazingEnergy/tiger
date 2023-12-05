import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/recipe_detail.dart';
import 'dart:convert';

class RecipeDataService {
  final String accessToken;
  final String id;
  RecipeDataService({required this.accessToken, required this.id});

  Future<List<RecipeDetail>> fetchRecipeDetails() async {
    final response = await http.get(
        Uri.parse('https://api.amzegy.com/core/api/v1/search/recipes/$id'),
        headers: {"Authentication": accessToken});

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      List<RecipeDetail> recipeDetails =
          jsonData.map((data) => RecipeDetail.fromJson(data)).toList();

      return recipeDetails;
    } else {
      throw Exception(
          'Failed to load data. Error code: ${response.statusCode}');
    }
  }
}
