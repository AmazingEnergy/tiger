import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/invoice_model.dart';

class InvoicesHistory extends StatelessWidget {
  final List<InvoiceModel> billingHistory;

  const InvoicesHistory({super.key, required this.billingHistory});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.h),
              child: const Text(
                "Billing History",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.v),
            _buildBillingHistoryHeaders(),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: billingHistory
                      .map((invoice) => Column(
                            children: [
                              _buildInvoiceRow(invoice),
                              const Divider(),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingHistoryHeaders() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Date',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              'Subscription Period',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'Total Fee',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow(InvoiceModel invoice) {
    DateTime periodEndDate =
        DateTime.fromMillisecondsSinceEpoch(invoice.periodEndDate * 1000)
            .add(const Duration(days: 30));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              dateTimeConverter(invoice.periodStartDate),
              style: const TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              "${shortDateTimeConverter(invoice.periodStartDate)} - ${shortDateTimeConverter(periodEndDate.millisecondsSinceEpoch ~/ 1000)}",
              style: const TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              "\$${(invoice.amount / 100).toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  static String dateTimeConverter(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate = DateFormat('MM/dd/yyy').format(dateTime);
    return formattedDate;
  }

  static String shortDateTimeConverter(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate = DateFormat('MM/dd/yy').format(dateTime);
    return formattedDate;
  }
}
