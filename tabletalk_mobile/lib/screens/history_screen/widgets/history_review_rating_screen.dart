// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/utils/size_utils.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/theme/app_decoration.dart';
import 'package:tabletalk_mobile/theme/theme_helper.dart';
import 'package:tabletalk_mobile/models/simple_rating_model.dart';
import 'package:tabletalk_mobile/screens/history_screen/widgets/history_review_rating_item.dart';
import 'package:tabletalk_mobile/services/review_rating_service.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/screens/detail_screen/recipe_detail_screen.dart';
import 'package:tabletalk_mobile/screens/detail_screen/restaurant_detail_screen.dart';
import 'package:tabletalk_mobile/services/recipe_data_service.dart';
import 'package:tabletalk_mobile/services/restaurant_data_serivce.dart';
import 'package:tabletalk_mobile/models/recipe_detail.dart';
import 'package:tabletalk_mobile/models/restaurant_detail.dart';

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
        widget.ratings = updatedRatings;
      });
    } catch (e) {
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
                            SizedBox(height: 20.v),
                            HistoryReviewRatingItem(
                              rating: widget.ratings[index],
                              onRatingUpdated: refreshRatings,
                              navigateToRecipeDetail: (id) =>
                                  goToRecipeDetailScreen(context, id),
                              navigateToRestaurantDetail: (id) =>
                                  goToRestaurantDetailScreen(context, id),
                            ),
                            SizedBox(height: 10.v),
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

  Future<RecipeDetail> getRecipeDetails(
      BuildContext context, String recipeId) async {
    final capturedContext = context;
    RecipeDetail recipeDetail;
    final authProvider =
        Provider.of<AuthProvider>(capturedContext, listen: false);
    if (authProvider.credentials != null) {
      final String accessToken = authProvider.credentials!.accessToken;

      RecipeDataService recipeDataService =
          RecipeDataService(accessToken: accessToken);

      recipeDetail = await recipeDataService.fetchRecipeDetails(recipeId);
    } else {
      throw Exception('Failed to load data');
    }

    return recipeDetail;
  }

  void goToRecipeDetailScreen(BuildContext context, String recipeId) async {
    RecipeDetail recipeDetail = await getRecipeDetails(context, recipeId);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(
          recipeDetail: recipeDetail,
        ),
      ),
    );
  }

  Future<RestaurantDetail> getRestaurantDetails(
      BuildContext context, String restaurantId) async {
    final capturedContext = context;
    RestaurantDetail restaurantDetail;
    final authProvider =
        Provider.of<AuthProvider>(capturedContext, listen: false);
    if (authProvider.credentials != null) {
      final String accessToken = authProvider.credentials!.accessToken;

      RestaurantDataService restaurantDataService =
          RestaurantDataService(accessToken: accessToken);

      restaurantDetail =
          await restaurantDataService.fetchRestaurantDetails(restaurantId);
    } else {
      throw Exception('Failed to load data');
    }

    return restaurantDetail;
  }

  void goToRestaurantDetailScreen(
      BuildContext context, String restaurantId) async {
    RestaurantDetail restaurantDetail =
        await getRestaurantDetails(context, restaurantId);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailScreen(
          restaurantDetail: restaurantDetail,
        ),
      ),
    );
  }
}
