// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/search_history_model.dart';
import 'package:tabletalk_mobile/models/search_id_model.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/recommendation_screen.dart';
import 'package:tabletalk_mobile/services/search_id_data_service.dart';

class HistorySearchItem extends StatelessWidget {
  final SearchHistoryModel searchHistoryModel;

  const HistorySearchItem({super.key, required this.searchHistoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          if (authProvider.credentials == null) {
            authProvider.loginAction(context);
          }
          final String accessToken = authProvider.credentials!.accessToken;

          SearchIdDataService searchIdDataService =
              SearchIdDataService(accessToken: accessToken);
          SearchIdDetailModel detail = await searchIdDataService
              .fetchSearchIdDetail(searchHistoryModel.id);
          _showDetailDialog(context, detail);
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error: $e")));
        }
      },
      child: Container(
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
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 10.v),
          ],
        ),
      ),
    );
  }

  void _showDetailDialog(
      BuildContext parentContext, SearchIdDetailModel detail) {
    showDialog(
      context: parentContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Search Result Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search Text: ${detail.searchText}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                const SizedBox(height: 10),
                ...detail.result.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        "- ${item.name}: ${item.reason}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("View Recommendations"),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => RecommendScreen(
                      searchText: detail.searchText,
                      searchId: detail.id,
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String dateTimeConverter(String str) {
    DateTime dateTime = DateTime.parse(str).toLocal();

    String formattedDateString =
        DateFormat("yyyy/MM/dd  -  hh:mma").format(dateTime);

    return formattedDateString;
  }
}
