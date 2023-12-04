import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/restaurant_detail.dart';
import 'dart:convert';

class RestaurantDataService {
  Future<List<RestaurantDetail>> fetchRestaurantDetails() async {
    final response = await http.get(Uri.parse('https://'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      List<RestaurantDetail> restaurantDetails = jsonData.map((data) {
        return RestaurantDetail.fromJson(data);
      }).toList();

      return restaurantDetails;
    } else {
      throw Exception(
          'Failed to load data. Error code: ${response.statusCode}');
    }
  }
}
