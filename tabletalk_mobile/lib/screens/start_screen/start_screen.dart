import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/main.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterPageRender);
  }

  _afterPageRender(_) {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
  }

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
                loading
                    ? _buildLoadingButton()
                    : Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return authProvider.credentials == null
                              ? _buildLoginButton()
                              : _buildStartSearchingButton();
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

  Widget _buildLoadingButton() {
    return SizedBox(
      width: 70.h,
      height: 70.h,
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 5.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomElevatedButton(
      height: 50.h,
      width: 200.h,
      text: "Login",
      buttonTextStyle: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 15,
      ),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientPrimaryToOnPrimaryContainerDecoration,
      onPressed: () {
        onTapLogin(context);
      },
    );
  }

  Widget _buildStartSearchingButton() {
    return CustomElevatedButton(
      height: 50.h,
      width: 200.h,
      text: "Start Searching",
      buttonTextStyle: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 15,
      ),
      rightIcon: Container(
        margin: EdgeInsets.only(left: 10.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgIconGeneralArrowright,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientPrimaryToOnPrimaryContainerDecoration,
      onPressed: () {
        goToSearchPage(context);
      },
    );
  }

  void onTapLogin(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loginAction();
  }

  void goToSearchPage(BuildContext context) async {
    Navigator.pushNamed(context, AppRoutes.screensContainer);
  }
}
