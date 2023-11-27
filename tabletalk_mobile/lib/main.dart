import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/theme/theme_helper.dart';
import 'package:tabletalk_mobile/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class AuthProvider with ChangeNotifier {
  final Auth0 _auth0 =
      Auth0('dev-ll366jry.us.auth0.com', 'NqkjtAs8ATY73GaEpWxPj00E1j0yumra');
  Credentials? _credentials;

  Credentials? get credentials => _credentials;

  Future<void> loginAction() async {
    try {
      final Credentials credentials = await _auth0
          .webAuthentication(scheme: "tabletalk")
          .login(audience: "https://api.amzegy.com/core/");
      _credentials = credentials;
      notifyListeners();
      print(_credentials?.accessToken);
    } catch (e, s) {
      debugPrint('[AuthProvider] login error: $e - stack: $s');
    }
  }

  Future<void> logoutAction() async {
    await _auth0.webAuthentication().logout();
    _credentials = null;
    notifyListeners();
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
