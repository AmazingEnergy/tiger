import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/models/recipe_detail.dart';
import 'package:tabletalk_mobile/models/restaurant_detail.dart';
import 'package:tabletalk_mobile/screens/billing_history_screen/billing_history_screen.dart';
import 'package:tabletalk_mobile/screens/detail_screen/recipe_detail_screen.dart';
import 'package:tabletalk_mobile/screens/detail_screen/restaurant_detail_screen.dart';
import 'package:tabletalk_mobile/screens/history_screen/history_screen_container.dart';
import 'package:tabletalk_mobile/screens/profile_screen/profile_screen.dart';
import 'package:tabletalk_mobile/screens/screens_container/screens_container.dart';
import 'package:tabletalk_mobile/screens/start_screen/start_screen.dart';
import 'package:tabletalk_mobile/screens/search_screen/search_screen.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/recommendation_screen.dart';
import 'package:tabletalk_mobile/screens/subscription_screen/subscription_screen.dart';

class AppRoutes {
  static const String startScreen = '/start_screen';
  static const String screensContainer = '/screens_container';
  static const String searchScreen = '/search_screen';
  static const String recommendationScreen = '/recommendation_screen';
  static const String recipeDetailScreen = '/recipe_detail_screen';
  static const String restaurantDetailScreen = '/restaurant_detail_screen';
  static const String profileScreen = '/profile_screen';
  static const String historyScreen = '/history_screen_container';
  static const String subscriptionScreen = '/subscription_screen';
  static const String billingHistoryScreen = '/billing_history_screen';

  static Map<String, WidgetBuilder> routes = {
    startScreen: (context) => const StartScreen(),
    searchScreen: (context) => const SearchScreen(),
    screensContainer: (context) => const ScreensContainer(),
    recipeDetailScreen: (context) {
      final RecipeDetail recipeDetail =
          ModalRoute.of(context)!.settings.arguments as RecipeDetail;
      return RecipeDetailScreen(recipeDetail: recipeDetail);
    },
    restaurantDetailScreen: (context) {
      final RestaurantDetail restaurantDetail =
          ModalRoute.of(context)!.settings.arguments as RestaurantDetail;
      return RestaurantDetailScreen(restaurantDetail: restaurantDetail);
    },
    recommendationScreen: (context) {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final String searchText = args['searchText'];
      final String searchId = args['searchId'];
      return RecommendScreen(
        searchText: searchText,
        searchId: searchId,
      );
    },
    profileScreen: (context) => const ProfileScreen(),
    historyScreen: (context) => const HistoryScreenContainer(),
    subscriptionScreen: (context) => const SubscriptionScreen(),
    billingHistoryScreen: (context) => const BillingHistoryScreen(),
  };
}
