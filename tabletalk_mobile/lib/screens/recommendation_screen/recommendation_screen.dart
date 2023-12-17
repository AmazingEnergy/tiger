// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tabletalk_mobile/models/recipe_detail.dart';
import 'package:tabletalk_mobile/models/recipe_search_result.dart';
import 'package:tabletalk_mobile/models/restaurant_detail.dart';
import 'package:tabletalk_mobile/models/restaurant_search_result.dart';
import 'package:tabletalk_mobile/models/search_id_model.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/providers/location_provider.dart';
import 'package:tabletalk_mobile/screens/detail_screen/recipe_detail_screen.dart';
import 'package:tabletalk_mobile/screens/detail_screen/restaurant_detail_screen.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/recipe_box.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/restaurant_box.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/search_box.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/like_dislike_buttons.dart';
import 'package:tabletalk_mobile/services/recipe_data_service.dart';
import 'package:tabletalk_mobile/services/recipe_result_data_service.dart';
import 'package:tabletalk_mobile/services/restaurant_data_serivce.dart';
import 'package:tabletalk_mobile/services/restaurant_result_data_service.dart';
import 'package:tabletalk_mobile/services/search_id_data_service.dart';

class RecommendScreen extends StatefulWidget {
  final String searchText;
  final String searchId;

  const RecommendScreen(
      {super.key, required this.searchText, required this.searchId});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  bool loading = true;
  List<RecipeSearchResult> recipes = List.empty(growable: true);
  List<RestaurantSearchResult> restaurants = List.empty(growable: true);
  String? feedback;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterPageRender);
  }

  _afterPageRender(_) {
    callApi(widget.searchText, widget.searchId);
  }

  callApi(String keyword, String searchId) async {
    setState(() {
      loading = true;
    });

    try {
      final capturedContext = context;
      final authProvider =
          Provider.of<AuthProvider>(capturedContext, listen: false);

      if (authProvider.credentials != null) {
        final String accessToken = authProvider.credentials!.accessToken;

        RecipeSearchService recipeSearchService =
            RecipeSearchService(accessToken: accessToken);
        try {
          recipes =
              await recipeSearchService.fetchRecipeSearchResults(searchId);
        } catch (recipeError) {
          if (kDebugMode) {
            print('Error fetching recipe: $recipeError');
          }
        }

        RestaurantSearchService restaurantSearchService =
            RestaurantSearchService(accessToken: accessToken);
        try {
          final location = Provider.of<LocationProvider>(context, listen: false)
              .currentLocation;
          double latitude = location?.latitude as double;
          double longtitude = location?.longitude as double;
          restaurants = await restaurantSearchService
              .fetchRestaurantSearchResults(searchId, latitude, longtitude);
        } catch (restaurantError) {
          if (kDebugMode) {
            print('Error fetching restaurant: $restaurantError');
          }
        }

        SearchIdDataService searchIdDataService =
            SearchIdDataService(accessToken: accessToken);
        try {
          SearchIdDetailModel searchIdDetail =
              await searchIdDataService.fetchSearchIdDetail(searchId);
          feedback = searchIdDetail.feedback;
        } catch (e) {
          if (kDebugMode) {
            print('Error fetching search detail: $e');
          }
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void _refreshFeedback() async {
    try {
      final String accessToken =
          Provider.of<AuthProvider>(context, listen: false)
              .credentials!
              .accessToken;
      SearchIdDataService searchIdDataService =
          SearchIdDataService(accessToken: accessToken);
      SearchIdDetailModel searchIdDetail =
          await searchIdDataService.fetchSearchIdDetail(widget.searchId);

      if (kDebugMode) {
        print('Old feedback: $feedback');
        print('New feedback: ${searchIdDetail.feedback}');
      }

      setState(() {
        feedback = searchIdDetail.feedback;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error refreshing feedback: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SearchBox(defaultText: widget.searchText),
                  const SizedBox(height: 10),
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: <Widget>[
                          const TabBar(
                            indicatorWeight: 3.0,
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                            tabs: [
                              Tab(
                                child: Text("Recipes"),
                              ),
                              Tab(
                                child: Text("Restaurant"),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _buildListRecipe(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _buildListRestaurant(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (feedback == null || feedback!.isEmpty)
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: LikeDislikeButtons(
                  searchId: widget.searchId,
                  onActionCompleted: _refreshFeedback,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildListRecipe() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: loading
          ? _buildShimmerLoadingWidgets(8)
          : recipes.map((e) {
              return InkWell(
                child: RecipeBox(model: e),
                onTap: () {
                  goToRecipeDetailScreen(context, e.id);
                },
              );
            }).toList(),
    );
  }

  Widget _buildListRestaurant() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: loading
          ? _buildShimmerLoadingWidgets(2)
          : restaurants.map((e) {
              return InkWell(
                child: RestaurantBox(model: e),
                onTap: () {
                  goToRestaurantDetailScreen(context, e.id);
                },
              );
            }).toList(),
    );
  }

  List<Widget> _buildShimmerLoadingWidgets(int count) {
    return List.generate(
      count,
      (index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 150,
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

    // ignore: use_build_context_synchronously
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
