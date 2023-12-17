import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/recipe_detail.dart';
import 'package:tabletalk_mobile/screens/detail_screen/widgets/recipe_ingredients.dart';
import 'package:tabletalk_mobile/screens/detail_screen/widgets/recipe_instructions.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeDetail recipeDetail;

  const RecipeDetailScreen({super.key, required this.recipeDetail});

  @override
  RecipeDetailScreenState createState() => RecipeDetailScreenState();
}

class RecipeDetailScreenState extends State<RecipeDetailScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  double currentRating = 0.0;
  bool isStarRated = false;

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
          child: Column(
            children: [
              SizedBox(height: 20.v),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CustomImageView(
                            imagePath: widget.recipeDetail.imageUrl,
                            height: 200.v,
                            width: double.infinity,
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                          ),
                          _buildRatingBar(),
                          _buildBackButton(),
                        ],
                      ),
                      SizedBox(height: 12.v),
                      _buildRecipeDetails(context),
                      SizedBox(height: 5.v),
                      Padding(
                        padding: EdgeInsets.only(left: 30.h),
                        child: Text(
                          widget.recipeDetail.author,
                          style: CustomTextStyles.bodyMediumBlack900,
                        ),
                      ),
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
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 400.v,
                        child: TabBarView(
                          controller: tabviewController,
                          children: [
                            RecipeIngredientsScreen(
                                ingredients: widget.recipeDetail.ingredients),
                            RecipeInstructionsScreen(
                              instructions: widget.recipeDetail.instructions,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.v),
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

  Widget _buildRecipeDetails(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 20.h,
                    child: Text(
                      widget.recipeDetail.name,
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar() {
    return Positioned(
      top: 16.0,
      right: 16.0,
      child: GestureDetector(
        onVerticalDragDown: (details) {
          setState(() {
            currentRating = 0.0;
            isStarRated = false;
          });
          _saveRating(currentRating);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: RatingBar.builder(
            initialRating: currentRating,
            minRating: 0.5,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 30.0,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: isStarRated ? Colors.amber : Colors.grey,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              setState(() {
                currentRating = rating;
                isStarRated = true;
              });
              _saveRating(currentRating);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 16.0,
      left: 16.0,
      child: GestureDetector(
        onTap: () {
          onTapImgArrowLeft(context);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowLeft,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
      ),
    );
  }

  void _saveRating(double rating) {
    // Add logic here to save the rating
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
