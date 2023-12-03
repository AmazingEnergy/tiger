// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabletalk_mobile/widgets/custom_top_bar.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';
import 'package:tabletalk_mobile/widgets/info_box.dart';

class RecommendationScreen extends StatelessWidget {
  RecommendationScreen({Key? key}) : super(key: key);

  TextEditingController askController = TextEditingController();

  final String recipeText = "Recipe";
  final String restaurantText = "Restaurant";

  final List<InfoBox> customRecipeInfoBoxes = [
    InfoBox(
        title: 'Recipe 1', leftText: 'Left Text 1', rightText: 'Right Text 1'),
    InfoBox(
        title: 'Recipe 2', leftText: 'Left Text 2', rightText: 'Right Text 2'),
    InfoBox(
        title: 'Recipe 3', leftText: 'Left Text 2', rightText: 'Right Text 2'),
    InfoBox(
        title: 'Recipe 4', leftText: 'Left Text 2', rightText: 'Right Text 2'),
    InfoBox(
        title: 'Recipe 5', leftText: 'Left Text 2', rightText: 'Right Text 2'),
    InfoBox(
        title: 'Recipe 6', leftText: 'Left Text 2', rightText: 'Right Text 2'),
    // ... (add more if needed)
  ];

  final List<InfoBox> customRestaurantInfoBoxes = [
    InfoBox(
        title: 'Restaurant 1',
        leftText: 'Left Text 1',
        rightText: 'Right Text 1'),
    InfoBox(
        title: 'Restaurant 2',
        leftText: 'Left Text 2',
        rightText: 'Right Text 2'),
    // ... (add more if needed)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
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
                            text: TextSpan(
                              style: const TextStyle(
                                color: Color.fromRGBO(253, 99, 124, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Search Results... ',
                                ),
                                TextSpan(
                                  text: '50 results',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 194, 194, 194),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          CustomTextFormField(
                            controller: askController,
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
                        SizedBox(height: 0),
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
                SizedBox(height: 16),
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
