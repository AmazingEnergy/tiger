import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  final String accessToken;

  PaymentService({required this.accessToken});

  // Fetches prices and the publishable key
  Future<Map<String, dynamic>> fetchPrices() async {
    var response = await http.get(
      Uri.parse(
          'https://api.amzegy.com/core/api/v1/customers/membership/prices'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load prices');
    }
  }

  Future<Map<String, dynamic>> createSubscription(String priceId) async {
    var response = await http.post(
      Uri.parse('https://api.amzegy.com/core/api/v1/customers/subscriptions'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({'priceId': priceId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create subscription');
    }
  }

  Future<Map<String, dynamic>> fetchSubscriptions() async {
    var response = await http.get(
      Uri.parse('https://api.amzegy.com/core/api/v1/customers/subscriptions'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch subscriptions');
    }
  }
}
