import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';

class RecipeIngredientsScreen extends StatefulWidget {
  final List<String> ingredients;

  const RecipeIngredientsScreen({super.key, required this.ingredients});

  @override
  RecipeIngredientsScreenState createState() => RecipeIngredientsScreenState();
}

class RecipeIngredientsScreenState extends State<RecipeIngredientsScreen>
    with AutomaticKeepAliveClientMixin<RecipeIngredientsScreen> {
  @override
  bool get wantKeepAlive => true;

  late MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 8.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Column(
                    children: [
                      SizedBox(height: 12.v),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.h,
                          vertical: 14.v,
                        ),
                        decoration: AppDecoration.fillGray.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder12,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (String ingredient in widget.ingredients)
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "$ingredient.",
                                  maxLines: 1000,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyles.bodyMediumGray900,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
