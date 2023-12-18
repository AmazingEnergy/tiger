import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/profile_model.dart';
import 'package:tabletalk_mobile/models/search_history_model.dart';
import 'package:tabletalk_mobile/models/simple_rating_model.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/screens/history_screen/widgets/history_review_rating_screen.dart';
import 'package:tabletalk_mobile/screens/history_screen/widgets/history_search_screen.dart';
import 'package:tabletalk_mobile/services/history_data_service.dart';
import 'package:tabletalk_mobile/services/review_rating_service.dart';
import 'package:tabletalk_mobile/services/user_profile_service.dart';

class HistoryScreenContainer extends StatefulWidget {
  const HistoryScreenContainer({super.key});

  @override
  HistoryScreenContainerState createState() => HistoryScreenContainerState();
}

class HistoryScreenContainerState extends State<HistoryScreenContainer>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  late HistoryDataService historyDataService;
  bool isProMember = false;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
    _loadUserProfileAndInitServices();
  }

  Future<void> _loadUserProfileAndInitServices() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.credentials == null) {
      await authProvider.loginAction(context);
    }
    final String accessToken = authProvider.credentials!.accessToken;

    UserProfileService userProfileService =
        UserProfileService(accessToken: accessToken);
    try {
      UserProfile userProfile = await userProfileService.getProfile();
      isProMember = userProfile.membership == "pro";
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user profile: $e');
      }
    }

    historyDataService = HistoryDataService(accessToken: accessToken);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

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
              Expanded(
                child: SizedBox(
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      _buildHistorySearchScreen(),
                      _buildReviewRatingScreen(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySearchScreen() {
    if (!isProMember) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Subscribe To The Membership Program To View The Search History",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    return FutureBuilder<List<SearchHistoryModel>>(
      future: historyDataService.fetchSearchHistoryData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${snapshot.error.toString()}')),
            );
          });
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return HistorySearchScreen(searchHistory: snapshot.data!);
        } else {
          return const Center(child: Text('No search history found'));
        }
      },
    );
  }

  Widget _buildReviewRatingScreen() {
    final ReviewRatingService reviewRatingService = ReviewRatingService(
        accessToken: Provider.of<AuthProvider>(context, listen: false)
            .credentials!
            .accessToken);

    return FutureBuilder<List<SimpleRatingModel>>(
      future: reviewRatingService.fetchReviewRatings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${snapshot.error.toString()}')),
            );
          });
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return HistoryReviewRatingScreen(ratings: snapshot.data!);
        } else {
          return const Center(child: Text('No reviews and ratings found'));
        }
      },
    );
  }

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
            fontSize: 13.fSize,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelColor: appTheme.gray700,
          unselectedLabelStyle: TextStyle(
            fontSize: 13.fSize,
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
              child: Text("Search"),
            ),
            Tab(
              child: Text("Reviews and ratings"),
            ),
          ],
        ),
      ),
    );
  }
}
