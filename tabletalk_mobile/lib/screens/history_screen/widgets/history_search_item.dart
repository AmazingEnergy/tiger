import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabletalk_mobile/core/app_export.dart';

// ignore: must_be_immutable
class FeedlistItemWidget extends StatelessWidget {
  const FeedlistItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 7.v),
                  child: Text(
                    dateTimeConverter("2023-12-12T06:48:34.000Z"), // time
                    style: CustomTextStyles.labelLargeGray800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 11.v),
          Container(
            width: 305.h,
            margin: EdgeInsets.only(
              left: 6.h,
              right: 36.h,
            ),
            child: Text(
              "Lately, I’ve been feeling very sad and stress. I would like to find something that could make me happy", // search text
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
          SizedBox(height: 8.v),
        ],
      ),
    );
  }

  String dateTimeConverter(String str) {
    DateTime dateTime = DateTime.parse(str);

    String formattedDateString =
        DateFormat("yyyy/MM/dd hh:mma").format(dateTime);

    return formattedDateString;
  }
}
