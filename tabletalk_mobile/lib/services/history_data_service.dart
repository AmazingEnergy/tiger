import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/search_id_model.dart';
import 'dart:convert';

class HistoryDataService {
  final String accessToken;

  HistoryDataService({required this.accessToken});

  Future<SearchIdModel> fetchSearchIdModels(String searchText) async {
    final response = await http.post(
      Uri.parse('https://api.amzegy.com/core/api/v1/search'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"searchText": searchText}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      SearchIdModel searchIdModel = SearchIdModel.fromJson(jsonData);

      return searchIdModel;
    } else {
      throw Exception(
          'Failed to load data. Error code: ${response.statusCode}');
    }
  }
}
