import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/widgets/custom_bottom_bar.dart';

class ScreensContainer extends StatefulWidget {
  const ScreensContainer({super.key});

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Navigator(
                      key: navigatorKey,
                      initialRoute: AppRoutes.searchScreen,
                      onGenerateRoute: (routeSetting) {
                        final String currentRouteName = routeSetting.name!;

                        if ([
                          AppRoutes.profileScreen,
                          AppRoutes.searchScreen,
                          AppRoutes.historyScreen
                        ].contains(currentRouteName)) {
                          return PageRouteBuilder(
                            pageBuilder: (ctx, ani, ani1) =>
                                getCurrentPage(currentRouteName, ctx),
                            transitionDuration: const Duration(seconds: 0),
                          );
                        }

                        return MaterialPageRoute(
                          builder: (context) {
                            final WidgetBuilder? builder =
                                AppRoutes.routes[currentRouteName];
                            if (builder != null) {
                              return builder(context);
                            } else {
                              return const Center(
                                  child: Text('Route not found'));
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        return AppRoutes.historyScreen;
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
