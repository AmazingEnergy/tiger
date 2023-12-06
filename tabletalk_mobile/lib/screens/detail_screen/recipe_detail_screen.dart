import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/recipe_detail.dart';
import 'package:tabletalk_mobile/screens/detail_screen/recipe_ingredients.dart';
import 'package:tabletalk_mobile/screens/detail_screen/recipe_instructions.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeDetail recipeDetail;

  const RecipeDetailScreen({super.key, required this.recipeDetail});

  @override
  RecipeDetailScreenState createState() => RecipeDetailScreenState();
}

class RecipeDetailScreenState extends State<RecipeDetailScreen>
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
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
          width: double.maxFinite,
          child: Column(children: [
            SizedBox(height: 20.v),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowLeft, //img
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                      margin: EdgeInsets.only(left: 30.h),
                      onTap: () {
                        onTapImgArrowLeft(context);
                      }),
                  SizedBox(height: 12.v),
                  _buildRecipeCard(context),
                  SizedBox(height: 12.v),
                  _buildRecipeDetails(context),
                  SizedBox(height: 5.v),
                  Padding(
                      padding: EdgeInsets.only(left: 30.h),
                      child: Text(widget.recipeDetail.author,
                          style: CustomTextStyles.bodyMediumBlack900)), //author
                  SizedBox(height: 10.v),
                  Center(
                    child: SizedBox(
                        height: 33.v,
                        width: 270.h,
                        child: TabBar(
                          controller: tabviewController,
                          labelPadding: EdgeInsets.zero,
                          labelColor: appTheme.black900,
                          labelStyle: TextStyle(
                            fontSize: 17.fSize,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelColor: appTheme.black900,
                          unselectedLabelStyle: TextStyle(
                            color: appTheme.pink30001,
                            fontSize: 17.fSize,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          indicator: BoxDecoration(
                            color: appTheme.pink30001,
                            borderRadius: BorderRadius.circular(20.h),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          tabs: const [
                            Tab(child: Text("Ingredients")),
                            Tab(child: Text("Instructions")),
                          ],
                        )),
                  ),
                  SizedBox(
                      height: 400.v,
                      child:
                          TabBarView(controller: tabviewController, children: [
                        RecipeIngredientsScreen(
                            ingredients: widget.recipeDetail.ingredients),
                        RecipeInstructionsScreen(
                          instructions: widget.recipeDetail.instructions,
                        )
                      ]))
                ])))
          ])),
    ));
  }

  /// Section Widget
  Widget _buildRecipeCard(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: SizedBox(
            height: 150.v,
            width: 315.h,
            child: Stack(alignment: Alignment.center, children: [
              CustomImageView(
                  imagePath: widget.recipeDetail.imageUrl, //imgpath
                  height: 200.v,
                  width: 300.h,
                  alignment: Alignment.center),
            ])));
  }

  /// Section Widget
  Widget _buildRecipeDetails(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: 20.h,
                child: Text(
                  widget.recipeDetail.name, // name
                  maxLines: 10,
                  style: CustomTextStyles.titleMediumSemiBold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgVuesaxOutlineTimer,
              height: 17.adaptSize,
              width: 17.adaptSize,
              margin: EdgeInsets.only(left: 12.h, top: 3.v, bottom: 2.v),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.h, top: 3.v, bottom: 2.v),
              child: Text(
                "${widget.recipeDetail.time} min",
                style: theme.textTheme.bodySmall,
              ), // time
            ),
          ],
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
