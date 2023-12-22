import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/invoice_model.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/screens/billing_history_screen/widgets/invoices_history.dart';
import 'package:tabletalk_mobile/services/billing_history_service.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';

class BillingHistoryScreen extends StatefulWidget {
  const BillingHistoryScreen({super.key});

  @override
  _BillingHistoryScreenState createState() => _BillingHistoryScreenState();
}

class _BillingHistoryScreenState extends State<BillingHistoryScreen> {
  late Future<List<InvoiceModel>> _billingHistoryFuture;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.credentials == null) {
      authProvider.loginAction(context);
    }
    final String accessToken = authProvider.credentials!.accessToken;
    _billingHistoryFuture = BillingHistoryService(accessToken: accessToken)
        .fetchBillingHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(13.h),
          child: Column(
            children: [
              _buildHeader(context),
              SizedBox(height: 19.v),
              _buildSubscriptionStatus(context),
              SizedBox(height: 19.v),
              _buildBillingHistory(),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: 10.h,
          right: 83.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 71.h,
                top: 19.v,
              ),
              child: Text(
                "History",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.h,
                    color: const Color.fromARGB(255, 191, 27, 82)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSubscriptionStatus(BuildContext context) {
    return Container(
      width: 347.h,
      margin: EdgeInsets.symmetric(horizontal: 1.h),
      padding: EdgeInsets.symmetric(
        horizontal: 4.h,
        vertical: 6.v,
      ),
      decoration: AppDecoration.outlineGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Your Membership",
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 8.v),
          Container(
            height: 39.v,
            width: 326.h,
            margin: EdgeInsets.only(left: 1.h),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Current Plan           Next billing date                    Total",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.v),
                        child: Text(
                          "Premium + ",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 53.h),
                        child: Text(
                          "6 January 2024",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1.v),
                    child: Text(
                      "1.99 /month",
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.v),
          CustomElevatedButton(
            height: 40.h,
            width: 150.h,
            buttonTextStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 12,
            ),
            text: "Cancel Subscription",
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientPinkAToPinkDecoration,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }

  Widget _buildBillingHistory() {
    return FutureBuilder<List<InvoiceModel>>(
      future: _billingHistoryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return InvoicesHistory(billingHistory: snapshot.data!);
        } else {
          return const Text('No data available');
        }
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          10,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String dateTimeConverter(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate = DateFormat('MM/dd/yyy').format(dateTime);

    return formattedDate;
  }

  String shortDateTimeConverter(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate = DateFormat('MM/dd/yy').format(dateTime);

    return formattedDate;
  }
}
