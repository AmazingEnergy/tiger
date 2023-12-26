import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:flutter/material.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Gradient button style
  static BoxDecoration get gradientPrimaryToOnPrimaryContainerDecoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.black9003f,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.onPrimaryContainer,
          ],
        ),
      );
  static BoxDecoration get gradientPinkToPinkADecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.pink300,
            appTheme.pinkA100,
          ],
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
  static BoxDecoration get gradientPinkAToPinkDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(180.h),
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.pinkA100,
            appTheme.pink300,
          ],
        ),
      );
}
