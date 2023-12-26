import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/providers/location_provider.dart';
import 'package:tabletalk_mobile/theme/theme_helper.dart';
import 'package:tabletalk_mobile/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load(fileName: ".env");

  AuthProvider authProvider = AuthProvider();
  await authProvider.loadCredentials();

  LocationProvider locationProvider = LocationProvider();
  await locationProvider.getCurrentLocation();
  ThemeHelper().changeTheme("primary");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => locationProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'TableTalk',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.startScreen,
      routes: AppRoutes.routes,
    );
  }
}
