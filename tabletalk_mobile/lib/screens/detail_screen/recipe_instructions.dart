import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/recipe_detail.dart';

class RecipeInstructionsScreen extends StatefulWidget {
  final List<Instruction> instructions;

  const RecipeInstructionsScreen({
    super.key,
    required this.instructions,
  });

  @override
  RecipeInstructionsScreenState createState() =>
      RecipeInstructionsScreenState();
}

class RecipeInstructionsScreenState extends State<RecipeInstructionsScreen>
    with AutomaticKeepAliveClientMixin<RecipeInstructionsScreen> {
  @override
  bool get wantKeepAlive => true;

  late MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Column(
                    children: [
                      for (int i = 0; i < widget.instructions.length; i++)
                        Column(
                          children: [
                            _buildStep(
                              context,
                              stepCounterLabel: "Step ${i + 1}",
                              stepCounterDescription:
                                  widget.instructions[i].description,
                            ),
                            SizedBox(height: 5.v),
                          ],
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

  Widget _buildStep(
    BuildContext context, {
    required String stepCounterLabel,
    required String stepCounterDescription,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stepCounterLabel,
            style: theme.textTheme.labelLarge!.copyWith(
              color: appTheme.gray900,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1.v),
          SizedBox(
            width: 400.h,
            child: Text(
              stepCounterDescription,
              maxLines: 1000,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyMediumBlack900_1.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
