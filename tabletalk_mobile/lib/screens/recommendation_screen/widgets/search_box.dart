import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class SearchBox extends StatelessWidget {
  Function(String, String)? onSearch;
  final FocusNode _searchFocusNode = FocusNode();
  final String defaultText;

  SearchBox({
    Key? key,
    this.onSearch,
    required this.defaultText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_searchFocusNode);
      },
      child: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Search Results...",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        color: Color(0xFFFD637C),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 6),
                    child: InkWell(
                      onTap: () {
                        // Bell icon logic
                      },
                      child: SvgPicture.asset(
                        ImageConstant.imgBell,
                        width: 42,
                        height: 42,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Focus(
                      focusNode: _searchFocusNode,
                      child: CustomTextFormField(
                        enabled: false,
                        hintText: defaultText,
                        textStyle: const TextStyle(color: Colors.black),
                        autofocus: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: () {
                        // Filter icon logic
                      },
                      child: SvgPicture.asset(
                        ImageConstant.imgFilter,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
