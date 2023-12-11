// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/widgets/custom_bottom_bar.dart';

class ScreensContainer extends StatefulWidget {
  ScreensContainer({Key? key}) : super(key: key);

  @override
  _ScreensContainerState createState() => _ScreensContainerState();
}

class _ScreensContainerState extends State<ScreensContainer> {
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
          Positioned.fill(
            child: Navigator(
              key: navigatorKey,
              initialRoute: AppRoutes.searchScreen,
              onGenerateRoute: (routeSetting) {
                final String currentRouteName = routeSetting.name!;

                // Check if the route is one of the three main pages
                if ([
                  AppRoutes.profileScreen,
                  AppRoutes.searchScreen,
                  //AppRoutes.otherMainPage
                ].contains(currentRouteName)) {
                  return PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(currentRouteName, ctx),
                    transitionDuration: const Duration(seconds: 0),
                  );
                }

                // For all other routes, use the default MaterialPageRoute
                return MaterialPageRoute(
                  builder: (context) {
                    final WidgetBuilder? builder =
                        AppRoutes.routes[currentRouteName];
                    if (builder != null) {
                      return builder(context);
                    } else {
                      return const Center(child: Text('Route not found'));
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(onChanged: (BottomBarEnum type) {
        final String currentRouteName = getCurrentRoute(type);
        if (navigatorKey.currentContext != null) {
          Navigator.pushNamed(
            navigatorKey.currentContext!,
            currentRouteName,
          );
        }
      }),
    );
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Clock:
        return AppRoutes.profileScreen;
      case BottomBarEnum.toolbarsearch:
        return AppRoutes.searchScreen;
      case BottomBarEnum.User:
        return AppRoutes.profileScreen;
      default:
        return "/";
    }
  }

  Widget getCurrentPage(String currentRoute, BuildContext context) {
    final WidgetBuilder? builder = AppRoutes.routes[currentRoute];
    if (builder != null) {
      return builder(context);
    } else {
      return const Center(child: Text('Route not found'));
    }
  }
}
