import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/main.dart';
import 'package:tabletalk_mobile/services/restaurant_data_serivce.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 210.v),
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
                      return CustomElevatedButton(
                        height: 50.h,
                        width: 200.h,
                        text: "Start Searching",
                        buttonTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15),
                        rightIcon: Container(
                          margin: EdgeInsets.only(left: 10.h),
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
                      );
                    }
                  },
                ),
                SizedBox(height: 70.v),
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
    final capturedContext = context;

    final authProvider =
        Provider.of<AuthProvider>(capturedContext, listen: false);

    if (authProvider.credentials != null) {
      final String accessToken = authProvider.credentials!.accessToken;
      RestaurantDataService restaurantDataService = RestaurantDataService(
          accessToken: accessToken, id: "dc9d4fe8-aa54-465d-b714-d8830890dc99");
      var restaurantData = await restaurantDataService.fetchRestaurantDetails();

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(
        capturedContext,
        AppRoutes.restaurantDetailScreen,
        arguments: restaurantData,
      );

      //Navigator.pushNamed(capturedContext, AppRoutes.screensContainer);
    } else {
      if (kDebugMode) {
        print("Access token is not available");
      }
    }
  }
}
