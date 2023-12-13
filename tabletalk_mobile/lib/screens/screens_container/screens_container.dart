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
  String _currentRoute = AppRoutes.searchScreen; // Set to initial route

  final List<String> routesWithoutBottomBar = [AppRoutes.startScreen];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.searchScreen,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final String newRouteName = settings.name ?? "";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _currentRoute = newRouteName;
        });
      }
    });

    return MaterialPageRoute(
      builder: (context) {
        final WidgetBuilder? builder = AppRoutes.routes[newRouteName];
        if (builder != null) {
          return builder(context);
        } else {
          return const Center(child: Text('Route not found'));
        }
      },
    );
  }

  Widget? _buildBottomNavigationBar() {
    if (routesWithoutBottomBar.contains(_currentRoute)) {
      return null;
    }

    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      final String newRoute = getCurrentRoute(type);
      if (navigatorKey.currentContext != null) {
        Navigator.pushNamed(
          navigatorKey.currentContext!,
          newRoute,
        );
      }
    });
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
