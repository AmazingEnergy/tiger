// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class SearchBox extends StatelessWidget {
  Function(String, String)? onSearch;
  final FocusNode _searchFocusNode = FocusNode();

  SearchBox({
    Key? key,
    this.onSearch,
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
                  Expanded(
                    child: Text(
                      "Our Recommendations",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        color: const Color(0xFFFD637C),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Text(
                    "50 results",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
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
                        hintText: "Search",
                        textStyle: TextStyle(color: Colors.black),
                        autofocus: false,
                        // onSubmitted: (textInput) {
                        //   var paramter2 = "x2";
                        //   if (onSearch != null) onSearch!(textInput, paramter2);
                        // },
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
