import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/utils/size_utils.dart';
import 'package:tabletalk_mobile/models/search_history_model.dart';
import 'package:tabletalk_mobile/screens/history_screen/widgets/history_search_item.dart';
import 'package:tabletalk_mobile/theme/app_decoration.dart';
import 'package:tabletalk_mobile/theme/theme_helper.dart';

class HistorySearchScreen extends StatefulWidget {
  final List<SearchHistoryModel> searchHistory;

  const HistorySearchScreen({super.key, required this.searchHistory});

  @override
  HistorySearchScreenState createState() => HistorySearchScreenState();
}

class HistorySearchScreenState extends State<HistorySearchScreen>
    with AutomaticKeepAliveClientMixin<HistorySearchScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              SizedBox(height: 38.v),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 21.h, right: 11.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        widget.searchHistory.length,
                        (index) => Column(
                          children: [
                            HistorySearchItem(
                                searchHistoryModel:
                                    widget.searchHistory[index]),
                            SizedBox(
                              width: 335.h,
                              child: Divider(
                                height: 1.v,
                                thickness: 1.v,
                                color: appTheme.blueGray100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
