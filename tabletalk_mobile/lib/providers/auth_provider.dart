import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';

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
    }
  }

  Future<void> loginAction(BuildContext context) async {
    try {
      final Credentials credentials = await _auth0
          .webAuthentication(scheme: "tabletalk")
          .login(audience: "https://api.amzegy.com/core/");
      _credentials = credentials;
      await _auth0.credentialsManager.storeCredentials(credentials);
      notifyListeners();
    } catch (e, s) {
      logoutAction();
      debugPrint('[AuthProvider] login error: $e - stack: $s');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: const Color.fromARGB(255, 255, 18, 1),
          content: SizedBox(
            height: 50.0,
            child: Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(text: "Login failed: "),
                    TextSpan(
                      text: "Verify Your Email",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: " or "),
                    TextSpan(
                      text: "Try Another Account",
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  Future<void> logoutAction() async {
    await _auth0.webAuthentication(scheme: "tabletalk").logout();
    _credentials = null;
    notifyListeners();
  }
}
