import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/recipe_detail.dart';
import 'dart:convert';

class RecipeDataService {
  Future<List<RecipeDetail>> fetchRecipeDetails() async {
    final response = await http.get(Uri.parse('https://'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      List<RecipeDetail> recipeDetails = jsonData.map((data) {
        return RecipeDetail(
          id: data['id'],
          name: data['name'],
          time: data['time'],
          author: data['author'],
          imageUrl: data['imageUrl'],
          ingredients: List<String>.from(data['ingredients']),
          instructions: List<Instruction>.from(
            data['instructions'].map((instruction) => Instruction(
                  step: instruction['step'],
                  description: instruction['description'],
                )),
          ),
        );
      }).toList();

      return recipeDetails;
    } else {
      throw Exception(
          'Failed to load data. Error code: ${response.statusCode}');
    }
  }
}
