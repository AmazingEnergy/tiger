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
  late Future<SubscriptionStatus> _subscriptionStatusFuture;

  @override
  void initState() {
    super.initState();
    _initData();
    _subscriptionStatusFuture = _fetchSubscriptionStatus();
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

  Future<SubscriptionStatus> _fetchSubscriptionStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.credentials == null) {
      authProvider.loginAction(context);
    }
    final String accessToken = authProvider.credentials!.accessToken;

    await Future.delayed(const Duration(seconds: 1));
    var billingService = BillingHistoryService(accessToken: accessToken);
    UpcomingInvoiceModel? _upcomingInvoice;
    ExpirationInvoiceModel? _expiredInvoice;
    try {
      _upcomingInvoice = await billingService.fetchUpcomingInvoice();
    } catch (e) {
      try {
        _expiredInvoice = await billingService.cancelSubscription();
      } catch (e) {}
    }

    if (_upcomingInvoice != null) {
      return SubscriptionStatus(
        currentPlan: "Premium+",
        dateLabel: "Next billing date",
        dateValue: dateTimeConverter(_upcomingInvoice!.periodStartDate),
        total:
            "\$${_upcomingInvoice!.amount / 100} ${_upcomingInvoice!.currency}",
      );
    } else if (_expiredInvoice != null) {
      return SubscriptionStatus(
        currentPlan: "Premium+",
        dateLabel: "Expiration Date",
        dateValue: dateTimeConverter(_expiredInvoice!.periodEndDate),
        total: "N/A",
      );
    } else {
      return SubscriptionStatus(
        currentPlan: "Normal",
        dateLabel: "Status",
        dateValue: "No active plan",
        total: "N/A",
      );
    }
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
              SizedBox(height: 30.v),
              _buildSubscriptionStatus(),
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
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "Billing History",
        style: TextStyle(
          color: Color(0xFFFD637C),
          fontSize: 24,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
    );
  }

  Widget _buildSubscriptionStatus() {
    return FutureBuilder<SubscriptionStatus>(
      future: _subscriptionStatusFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerBox();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final status = snapshot.data!;
          return Container(
            width: 347.h,
            margin: EdgeInsets.symmetric(horizontal: 1.h),
            padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 6.v),
            decoration: AppDecoration.outlineGray,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: const Text(
                    "Your Membership",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildColumnWithLabelAndData(
                        "Current Plan", status.currentPlan),
                    _buildColumnWithLabelAndData(
                        status.dateLabel, status.dateValue),
                    _buildColumnWithLabelAndData("Total", status.total),
                  ],
                ),
                SizedBox(height: 20.v),
                if (status.dateLabel == "Next billing date")
                  _buildActionButton("Cancel Subscription", _cancelSubscription)
              ],
            ),
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return CustomElevatedButton(
      height: 40.h,
      width: 150.h,
      buttonTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
      text: text,
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomButtonStyles.gradientPinkAToPinkDecoration,
      alignment: Alignment.centerRight,
      onPressed: onPressed,
    );
  }

  Widget _buildColumnWithLabelAndData(String label, String data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.v),
        Text(
          data,
          style: theme.textTheme.bodySmall,
        ),
      ],
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

  Widget _buildShimmerBox() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 347.h,
        height: 100.h,
        padding: EdgeInsets.all(16.h),
        decoration: AppDecoration.outlineGray,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            3,
            (_) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Container(
                height: 8.h,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
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

  void _cancelSubscription() async {
    var billingService = BillingHistoryService(
        accessToken: Provider.of<AuthProvider>(context, listen: false)
            .credentials!
            .accessToken);

    await billingService.cancelSubscription();

    setState(() {
      _subscriptionStatusFuture = _fetchSubscriptionStatus();
    });
  }
}

class SubscriptionStatus {
  final String currentPlan;
  final String dateLabel;
  final String dateValue;
  final String total;

  SubscriptionStatus({
    required this.currentPlan,
    required this.dateLabel,
    required this.dateValue,
    required this.total,
  });
}
