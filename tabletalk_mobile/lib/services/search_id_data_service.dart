import 'package:http/http.dart' as http;
import 'package:tabletalk_mobile/models/search_id.dart';
import 'dart:convert';

class SearchIdDataService {
  final String accessToken;

  SearchIdDataService({required this.accessToken});

  Future<SearchId> fetchSearchIds() async {
    final response = await http.get(
      Uri.parse('https://api.amzegy.com/core/api/v1/search'),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      SearchId searchId = SearchId.fromJson(jsonData);
      return searchId;
    } else {
      throw Exception(
          'Failed to load data. Error code: ${response.statusCode}');
    }
  }
}
