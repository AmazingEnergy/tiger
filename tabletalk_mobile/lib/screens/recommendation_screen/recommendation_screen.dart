import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/models/api_sample_search_result.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/recipe_box.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/restaurant_box.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/search_box.dart';
import 'package:http/http.dart' as http;

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({super.key});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  bool loading = true;
  List<RecipeModel> recipes = List.empty(growable: true);
  List<RestaurantModel> restaurants = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(_afterPageRender);
  }

  _afterPageRender(_) {
    callApi("");
  }

  callApi(String keyword) async {
    setState(() {
      loading = true;
    });

    try {
      final response = await http
          .get(Uri.parse('https://glamo.wiremockapi.cloud/tabletalk'));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        var apiResult = ApiSearchResult.fromJson(json);
        recipes = apiResult.recipes ?? List.empty();
        restaurants = apiResult.restaurants ?? List.empty();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle exceptions here
      print('Error: $e');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              SearchBox(onSearch: (keyword, param1) {
                callApi(keyword);
              }),
              SizedBox(height: 10),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      TabBar(
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
      ),
    );
  }

  Widget _buildListRecipe() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: loading
          ? _buildLoadingWidgets(2) // 2 is the number of placeholder widgets
          : recipes.map((e) {
              return InkWell(child: RecipeBox(model: e));
            }).toList(),
    );
  }

  Widget _buildListRestaurant() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: loading
          ? _buildLoadingWidgets(2) // 2 is the number of placeholder widgets
          : restaurants.map((e) {
              return InkWell(
                child: RestaurantBox(
                  model: e,
                ),
              );
            }).toList(),
    );
  }

  List<Widget> _buildLoadingWidgets(int count) {
    return List.generate(
      count,
      (index) => Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        height: 150,
      ),
    );
  }
}
