import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/screens/start_screen/start_screen.dart';
import 'package:tabletalk_mobile/screens/search_screen/search_screen.dart';

class AppRoutes {
  static const String startScreen = '/start_screen';

  //static const String searchScreen = '/search_screen';

  static Map<String, WidgetBuilder> routes = {
    startScreen: (context) => const StartScreen(),
    //searchScreen: (context) => const SearchScreen(),
  };
}
