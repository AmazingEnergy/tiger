import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/main.dart';
import 'package:tabletalk_mobile/widgets/custom_bottom_bar.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: CustomElevatedButton(
          height: 50.h,
          width: 200.h,
          text: "Logout",
          buttonTextStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
          buttonStyle: CustomButtonStyles.none,
          decoration:
              CustomButtonStyles.gradientPrimaryToOnPrimaryContainerDecoration,
          onPressed: () {
            _logout(context);
          },
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logoutAction();

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, AppRoutes.startScreen);
  }
}
