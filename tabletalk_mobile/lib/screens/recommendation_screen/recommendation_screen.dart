// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/recipe_search_result.dart';
import 'package:tabletalk_mobile/models/restaurant_search_result.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/custom_top_bar.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/recipe_result_info_box.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/widgets/restaurant_result_info_box.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';

class RecommendationScreen extends StatelessWidget {
  RecommendationScreen({
    super.key,
    required this.recipeResult,
    required this.restaurantResult,
  });

  final TextEditingController askController = TextEditingController();

  final String recipeText = "Recipe";
  final String restaurantText = "Restaurant";

  final List<RecipeResultInfoBox> customRecipeInfoBoxes = [];
  final List<RestaurantResultInfoBox> customRestaurantInfoBoxes = [];

  final List<RecipeSearchResult> recipeResult;
  final List<RestaurantSearchResult> restaurantResult;

  @override
  Widget build(BuildContext context) {
    for (var result in recipeResult) {
      customRecipeInfoBoxes.add(RecipeResultInfoBox(
          id: result.id,
          name: result.name,
          author: "author",
          time: result.time,
          reason: result.reason,
          imageUrl: result.imageUrl));
    }

    for (var result in restaurantResult) {
      customRestaurantInfoBoxes.add(RestaurantResultInfoBox(
        id: result.id,
        name: result.name,
        rating: result.rating,
        reason: result.reason,
        imageUrl: result.imageUrl,
      ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Color.fromRGBO(253, 99, 124, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Our recommendations...',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: askController,
                            enabled: false,
                            hintText: "Ask us anything!",
                            textInputAction: TextInputAction.done,
                            textStyle: TextStyle(
                              color: askController.text.isNotEmpty
                                  ? const Color.fromARGB(255, 194, 194, 194)
                                  : const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, left: 9),
                          child: InkWell(
                            onTap: () {
                              // bell icon  logic
                            },
                            child: SvgPicture.asset(
                              ImageConstant.imgBell,
                              width: 42,
                              height: 42,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0, left: 10),
                          child: InkWell(
                            onTap: () {
                              // filter icon ogic
                            },
                            child: SvgPicture.asset(
                              ImageConstant.imgFilter,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTopBar(
                  onChanged: (type) {},
                  menuItems: [
                    TopMenuModel(text: recipeText, type: TopBarEnum.Item1),
                    TopMenuModel(text: restaurantText, type: TopBarEnum.Item2),
                  ],
                  recipeInfoBoxes: customRecipeInfoBoxes,
                  restaurantInfoBoxes: customRestaurantInfoBoxes,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
