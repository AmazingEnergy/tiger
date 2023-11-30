import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/main.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';
import 'package:tabletalk_mobile/routes/app_routes.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController askController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgStartingPage,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillOnPrimary.copyWith(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgStartingPage,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: 11.h,
                top: 64.v,
                right: 11.h,
              ),
              child: Column(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgImage3,
                    height: 176.v,
                    width: 325.h,
                  ),
                  SizedBox(height: 87.v),
                  CustomTextFormField(
                    controller: askController,
                    hintText: "Ask us anything!",
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 8.v),
                  CustomElevatedButton(
                    text: "Submit",
                    onPressed: () {
                      print(askController.text); // button press
                    },
                    buttonStyle: CustomButtonStyles.none,
                    decoration: CustomButtonStyles
                        .gradientPrimaryToOnPrimaryContainerDecoration,
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
