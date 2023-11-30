import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/theme/theme_helper.dart';
import 'package:tabletalk_mobile/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');
  AuthProvider authProvider = AuthProvider();
  await authProvider.loadCredentials();
  runApp(
    ChangeNotifierProvider(
      create: (_) => authProvider,
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
    if (isLoggedIn) {
      _credentials = await _auth0.credentialsManager.credentials();
      notifyListeners();
      print(_credentials?.accessToken);
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
      debugPrint('[AuthProvider] login error: $e - stack: $s');
    }
  }

  Future<void> logoutAction() async {
    await _auth0.webAuthentication(scheme: "tabletalk").logout();
    _credentials = null;
    notifyListeners();
  }
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
