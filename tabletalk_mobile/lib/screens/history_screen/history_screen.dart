import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';

// ignore_for_file: must_be_immutable
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              SizedBox(height: 19.v),
              Text(
                "History",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.h,
                    color: const Color.fromARGB(255, 191, 27, 82)),
              ),
              SizedBox(height: 29.v),
              _buildTabview(context),
              SizedBox(
                height: 471.v,
                child: TabBarView(
                  controller: tabviewController,
                  children: [
                    //HistoryScreenSearchPage(),
                    //HistoryScreenSearchPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 50.v,
      width: 330.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.h),
        border: Border.all(
          color: appTheme.blueGray300,
          width: 1.h,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.h),
        child: TabBar(
          controller: tabviewController,
          labelPadding: EdgeInsets.zero,
          labelColor: appTheme.gray100,
          labelStyle: TextStyle(
            fontSize: 12.fSize,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelColor: appTheme.gray700,
          unselectedLabelStyle: TextStyle(
            fontSize: 12.fSize,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: appTheme.pinkA100,
            borderRadius: BorderRadius.circular(8.h),
          ),
          tabs: const [
            Tab(
              child: Text(
                "Search",
              ),
            ),
            Tab(
              child: Text(
                "Reviews and ratings",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
