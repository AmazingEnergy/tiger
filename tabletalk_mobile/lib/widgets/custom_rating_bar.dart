import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tabletalk_mobile/core/app_export.dart';

class CustomRatingBar extends StatelessWidget {
  CustomRatingBar({
    super.key,
    this.alignment,
    this.ignoreGestures,
    this.initialRating,
    this.itemSize,
    this.itemCount,
    this.color,
    this.unselectedColor,
    this.onRatingUpdate,
    this.viewOnly = false,
  });

  final Alignment? alignment;
  final bool? ignoreGestures;
  final double? initialRating;
  final double? itemSize;
  final int? itemCount;
  final Color? color;
  final Color? unselectedColor;
  final Function(double)? onRatingUpdate;
  final bool viewOnly;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: ratingBarWidget,
          )
        : ratingBarWidget;
  }

  Widget get ratingBarWidget => RatingBar.builder(
        ignoreGestures: viewOnly ? true : (ignoreGestures ?? false),
        initialRating: initialRating ?? 0,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemSize: itemSize ?? 16.v,
        unratedColor: unselectedColor ?? appTheme.gray300,
        itemCount: itemCount ?? 5,
        updateOnDrag: !viewOnly,
        itemBuilder: (context, _) {
          return Icon(
            Icons.star,
            color: color ?? appTheme.amberA700,
          );
        },
        onRatingUpdate: viewOnly ? (_) {} : onRatingUpdate ?? (_) {},
      );
}
