// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/utils/size_utils.dart';
import 'package:tabletalk_mobile/theme/app_decoration.dart';
import 'package:tabletalk_mobile/theme/theme_helper.dart';
import 'package:tabletalk_mobile/models/simple_rating_model.dart';
import 'package:tabletalk_mobile/screens/history_screen/widgets/history_review_rating_item.dart';
import 'package:tabletalk_mobile/services/review_rating_service.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/main.dart'; // Import the AuthProvider

class HistoryReviewRatingScreen extends StatefulWidget {
  late List<SimpleRatingModel> ratings;

  HistoryReviewRatingScreen({super.key, required this.ratings});

  @override
  HistoryReviewRatingScreenState createState() =>
      HistoryReviewRatingScreenState();
}

class HistoryReviewRatingScreenState extends State<HistoryReviewRatingScreen>
    with AutomaticKeepAliveClientMixin<HistoryReviewRatingScreen> {
  @override
  bool get wantKeepAlive => true;

  void refreshRatings() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      ReviewRatingService reviewRatingService = ReviewRatingService(
          accessToken: authProvider.credentials!.accessToken);

      List<SimpleRatingModel> updatedRatings =
          await reviewRatingService.fetchReviewRatings();
      setState(() {
        widget.ratings = updatedRatings; // Update the ratings list
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to refresh ratings: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              SizedBox(height: 38.v),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 21.h, right: 11.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        widget.ratings.length,
                        (index) => Column(
                          children: [
                            HistoryReviewRatingItem(
                              rating: widget.ratings[index],
                              onRatingUpdated: refreshRatings,
                            ),
                            SizedBox(
                              width: 335.h,
                              child: Divider(
                                height: 1.v,
                                thickness: 1.v,
                                color: appTheme.blueGray100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
