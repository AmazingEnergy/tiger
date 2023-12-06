// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
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
          Navigator(
            key: navigatorKey,
            initialRoute: AppRoutes.searchScreen,
            onGenerateRoute: (routeSetting) {
              final String currentRouteName = routeSetting.name!;
              return PageRouteBuilder(
                pageBuilder: (ctx, ani, ani1) =>
                    getCurrentPage(currentRouteName, ctx),
                transitionDuration: const Duration(seconds: 0),
              );
            },
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
        final String currentRouteName = getCurrentRoute(type);
        Navigator.pushNamed(navigatorKey.currentContext!, currentRouteName);
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

  Widget getCurrentPage(String currentRoute, BuildContext context) {
    final WidgetBuilder? builder = AppRoutes.routes[currentRoute];
    if (builder != null) {
      return builder(context);
    } else {
      // Handle case where the route is not found
      return const Center(child: Text('Route not found'));
    }
  }
}
