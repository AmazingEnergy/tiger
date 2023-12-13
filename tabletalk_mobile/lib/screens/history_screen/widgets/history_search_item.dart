import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/search_history_model.dart';

class HistorySearchItem extends StatelessWidget {
  final SearchHistoryModel searchHistoryModel;

  const HistorySearchItem({super.key, required this.searchHistoryModel});

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
                    dateTimeConverter(searchHistoryModel.time),
                    style: CustomTextStyles.labelLargeGray800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 11.v),
          Container(
            width: 305.h,
            margin: EdgeInsets.only(left: 6.h, right: 36.h),
            child: Text(
              searchHistoryModel.searchText,
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
        DateFormat("yyyy/MM/dd  -  hh:mma").format(dateTime);
    return formattedDateString;
  }
}
