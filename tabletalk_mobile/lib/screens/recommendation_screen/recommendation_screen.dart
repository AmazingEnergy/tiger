import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';
import 'package:tabletalk_mobile/widgets/custom_top_bar.dart'; // Import CustomTopBar

// ignore: must_be_immutable
class RecommendationScreen extends StatelessWidget {
  RecommendationScreen({Key? key}) : super(key: key);

  TextEditingController askController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search Results',
                          style: TextStyle(
                            color: Color.fromRGBO(253, 99, 124, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '50 results',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 194, 194, 194),
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 8),
                        CustomTextFormField(
                          controller: askController,
                          hintText: "Ask us anything!",
                          textInputAction: TextInputAction.done,
                          textStyle: TextStyle(
                            color: askController.text.isNotEmpty
                                ? const Color.fromARGB(255, 194, 194, 194)
                                : const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 9.0, left: 10),
                        child: InkWell(
                          onTap: () {
                            //  bell icon click logic here
                          },
                          child: SvgPicture.asset(
                            ImageConstant.imgBell,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0, left: 10),
                        child: InkWell(
                          onTap: () {
                            // icon click logic here
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
                ],
              ),
              SizedBox(height: 16),
              // Second Row
              CustomTopBar(),
            ],
          ),
        ),
      ),
    );
  }
}
