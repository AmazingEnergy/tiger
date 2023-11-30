// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/screens/search_screen/search_screen.dart';
import 'package:tabletalk_mobile/widgets/custom_bottom_bar.dart';

class ScreensContainer extends StatelessWidget {
  ScreensContainer({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              image: DecorationImage(
                image: AssetImage(ImageConstant.imgStartingPage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Navigator(
            key: navigatorKey,
            initialRoute: AppRoutes.searchScreen,
            onGenerateRoute: (routeSetting) => PageRouteBuilder(
              pageBuilder: (ctx, ani, ani1) =>
                  getCurrentPage(routeSetting.name!),
              transitionDuration: const Duration(seconds: 0),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: CustomBottomBar(onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      }),
    );
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Clock:
        return "/";
      case BottomBarEnum.toolbarsearch:
        return AppRoutes.searchScreen;
      case BottomBarEnum.User:
        return "/";
      default:
        return "/";
    }
  }

  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.searchScreen:
        return SearchScreen();
      default:
        return const DefaultWidget();
    }
  }
}
