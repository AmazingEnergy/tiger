import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgStartingPage),
                        fit: BoxFit.cover)),
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.h, vertical: 56.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      CustomImageView(
                          imagePath: ImageConstant.imgImage3,
                          height: 176.v,
                          width: 325.h),
                      SizedBox(height: 85.v),
                      Container(
                        margin: EdgeInsets.only(left: 39.h, right: 38.h),
                        child: Text(
                          "Welcome to TableTalk\nA food recommendation assistant",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.labelLargeRed300,
                        ),
                      ),
                      SizedBox(height: 81.v),
                      CustomElevatedButton(
                          width: 111.h,
                          text: "Login",
                          buttonStyle: CustomButtonStyles.none,
                          decoration: CustomButtonStyles
                              .gradientPrimaryToOnPrimaryContainerDecoration,
                          onPressed: () {
                            onTapLogin(context);
                          }),
                      SizedBox(height: 70.v),
                      CustomElevatedButton(
                          width: 161.h,
                          text: "Start Searching",
                          rightIcon: Container(
                              margin: EdgeInsets.only(left: 14.h),
                              child: CustomImageView(
                                  imagePath:
                                      ImageConstant.imgIconGeneralArrowright,
                                  height: 20.adaptSize,
                                  width: 20.adaptSize)),
                          buttonStyle: CustomButtonStyles.none,
                          decoration: CustomButtonStyles
                              .gradientPrimaryToOnPrimaryContainerDecoration,
                          onPressed: () {
                            onTapStartSearching(context);
                          }),
                      SizedBox(height: 5.v)
                    ])))));
  }

  onTapLogin(BuildContext context) {}

  /// Navigates to the search screen when the action is triggered.
  onTapStartSearching(BuildContext context) {
    //Navigator.pushNamed(context, AppRoutes.searchScreen);
  }
}
