import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tabletalk_mobile/models/simple_rating_model.dart'; // Ensure this import is correct

class ReviewRatingService {
  final String accessToken;

  ReviewRatingService({required this.accessToken});

  Future<List<SimpleRatingModel>> fetchReviewRatings() async {
    final response = await http.get(
      Uri.parse('https://api.amzegy.com/core/api/v1/reviews/ratings'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> items = jsonData['items'];

      List<SimpleRatingModel> ratings = items
          .map((jsonItem) => SimpleRatingModel.fromJson(jsonItem))
          .toList();

      return ratings;
    } else {
      throw Exception(
          'Failed to load reviews and ratings. Error code: ${response.statusCode}');
    }
  }

  Future<void> createRating(
      String referenceId, String rateFor, double rating) async {
    final response = await http.post(
      Uri.parse('https://api.amzegy.com/core/api/v1/reviews/ratings'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
      body: json.encode({
        "referenceId": referenceId,
        "rateFor": rateFor,
        "rating": rating,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to create rating. Error code: ${response.statusCode}');
    }
  }

  Future<void> updateRating(String id, double rating) async {
    final response = await http.put(
      Uri.parse('https://api.amzegy.com/core/api/v1/reviews/ratings/$id'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
      body: json.encode({
        "rating": rating,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to update rating. Error code: ${response.statusCode}');
    }
  }
}
