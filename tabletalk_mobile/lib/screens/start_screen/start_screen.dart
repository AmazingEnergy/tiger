import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/main.dart';
import 'package:tabletalk_mobile/screens/start_screen/widgets/profile.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';
import 'package:tabletalk_mobile/routes/app_routes.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgStartingPage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 56.v),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgImage3,
                  height: 176.v,
                  width: 325.h,
                ),
                SizedBox(height: 80.v),
                SizedBox(height: 70.v),
                SizedBox(height: 60.v),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.credentials == null) {
                      return CustomElevatedButton(
                        width: 111.h,
                        text: "Login",
                        buttonStyle: CustomButtonStyles.none,
                        decoration: CustomButtonStyles
                            .gradientPrimaryToOnPrimaryContainerDecoration,
                        onPressed: () {
                          onTapLogin(context);
                        },
                      );
                    } else {
                      //onTapStartSearching(context);
                      return const Text("");
                    }
                  },
                ),
                SizedBox(height: 70.v),
                CustomElevatedButton(
                  width: 161.h,
                  text: "Start Searching",
                  rightIcon: Container(
                    margin: EdgeInsets.only(left: 14.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgIconGeneralArrowright,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.none,
                  decoration: CustomButtonStyles
                      .gradientPrimaryToOnPrimaryContainerDecoration,
                  onPressed: () {
                    onTapStartSearching(context);
                  },
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapLogin(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loginAction();
  }

  void onTapStartSearching(BuildContext context) async {
    //Navigator.pushNamed(context, AppRoutes.searchScreen);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logoutAction();
  }
}
