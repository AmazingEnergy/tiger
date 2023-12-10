import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/theme/theme_helper.dart';
import 'package:tabletalk_mobile/routes/app_routes.dart';
import 'package:location/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load(fileName: ".env");

  ThemeHelper().changeTheme('primary');
  AuthProvider authProvider = AuthProvider();
  await authProvider.loadCredentials();

  LocationProvider locationProvider = LocationProvider();
  await locationProvider.getCurrentLocation();

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

class AuthProvider with ChangeNotifier {
  final Auth0 _auth0 =
      Auth0('dev-ll366jry.us.auth0.com', 'NqkjtAs8ATY73GaEpWxPj00E1j0yumra');
  Credentials? _credentials;

  Credentials? get credentials => _credentials;

  Future<void> loadCredentials() async {
    bool isLoggedIn = await _auth0.credentialsManager.hasValidCredentials();
    print(isLoggedIn);
    if (isLoggedIn) {
      _credentials = await _auth0.credentialsManager.credentials();
      notifyListeners();
      print(_credentials?.accessToken);
    } else {
      logoutAction();
    }
  }

  Future<void> loginAction() async {
    try {
      final Credentials credentials = await _auth0
          .webAuthentication(scheme: "tabletalk")
          .login(audience: "https://api.amzegy.com/core/");
      _credentials = credentials;
      print("accessToken");
      print(_credentials?.accessToken);
      await _auth0.credentialsManager.storeCredentials(credentials);

      notifyListeners();
    } catch (e, s) {
      logoutAction();
      debugPrint('[AuthProvider] login error: $e - stack: $s');
    }
  }

  Future<void> logoutAction() async {
    await _auth0.webAuthentication(scheme: "tabletalk").logout();
    _credentials = null;
    notifyListeners();
  }
}

class LocationProvider with ChangeNotifier {
  final Location _location = Location();
  LocationData? _currentLocation;

  LocationData? get currentLocation => _currentLocation;

  Future<void> getCurrentLocation() async {
    try {
      _currentLocation = await _location.getLocation();
      notifyListeners();
    } catch (e) {
      debugPrint('[LocationProvider] Error getting location: $e');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

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
