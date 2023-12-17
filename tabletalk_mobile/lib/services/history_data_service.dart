import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tabletalk_mobile/models/search_history_model.dart';

class HistoryDataService {
  final String accessToken;

  HistoryDataService({required this.accessToken});

  Future<List<SearchHistoryModel>> fetchSearchHistoryData() async {
    final response = await http.get(
      Uri.parse('https://api.amzegy.com/core/api/v1/search/history'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> items = jsonData['items'];

      List<SearchHistoryModel> searchHistory = items
          .map((jsonItem) => SearchHistoryModel.fromJson(jsonItem))
          .toList();

      return searchHistory;
    } else {
      throw Exception(
          'Failed to load search history. Error code: ${response.statusCode}');
    }
  }
}
