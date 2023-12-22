import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tabletalk_mobile/models/invoice_model.dart';

class BillingHistoryService {
  final String accessToken;

  BillingHistoryService({required this.accessToken});

  Future<List<InvoiceModel>> fetchBillingHistoryData() async {
    final response = await http.get(
      Uri.parse('https://api.amzegy.com/core/api/v1/customers/invoices'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> items = jsonData['items'];

      List<InvoiceModel> billingHistory =
          items.map((jsonItem) => InvoiceModel.fromJson(jsonItem)).toList();

      return billingHistory;
    } else {
      throw Exception(
          'Failed to load billing history. Error code: ${response.body}');
    }
  }

  Future<UpcomingInvoiceModel> fetchUpcomingInvoice() async {
    final response = await http.get(
      Uri.parse(
          'https://api.amzegy.com/core/api/v1/customers/subscriptions/upcoming'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      UpcomingInvoiceModel upcomingSubscription =
          UpcomingInvoiceModel.fromJson(jsonData);

      return upcomingSubscription;
    } else {
      throw Exception(
          'Failed to load upcoming subscription data. Error code: ${response.statusCode}');
    }
  }

  Future<ExpirationInvoiceModel> cancelSubscription() async {
    final response = await http.put(
      Uri.parse(
          'https://api.amzegy.com/core/api/v1/customers/subscriptions/cancel'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return ExpirationInvoiceModel.fromJson(jsonData);
    } else {
      throw Exception(
          'Failed to cancel subscription. Error code: ${response.body}');
    }
  }
}
