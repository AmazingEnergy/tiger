import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/main.dart';
import 'package:tabletalk_mobile/models/search_id.dart';
import 'package:tabletalk_mobile/services/search_id_data_service.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController askController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgStartingPage,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillOnPrimary.copyWith(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgStartingPage,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: 11.h,
                top: 64.v,
                right: 11.h,
              ),
              child: Column(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgImage3,
                    height: 176.v,
                    width: 325.h,
                  ),
                  SizedBox(height: 87.v),
                  CustomTextFormField(
                    controller: askController,
                    hintText: "Ask us anything!",
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 8.v),
                  CustomElevatedButton(
                    height: 35.h,
                    buttonTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15),
                    text: "Submit",
                    onPressed: () {
                      String searchText = askController.text;
                      print(searchText == ''); // button press
                      if (searchText != '') {
                        goToResultPage(context, searchText);
                      }
                    },
                    buttonStyle: CustomButtonStyles.none,
                    decoration: CustomButtonStyles
                        .gradientPrimaryToOnPrimaryContainerDecoration,
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getSearchId(BuildContext context, String searchText) async {
    final capturedContext = context;
    SearchId searchId;
    final authProvider =
        Provider.of<AuthProvider>(capturedContext, listen: false);
    if (authProvider.credentials != null) {
      final String accessToken = authProvider.credentials!.accessToken;

      SearchIdDataService searchIdDataService =
          SearchIdDataService(accessToken: accessToken);

      searchId = await searchIdDataService.fetchSearchIds(searchText);
    } else {
      throw Exception('Failed to load data');
    }

    return searchId.id;
  }

  void goToResultPage(BuildContext context, String searchText) async {
    String searchId = await getSearchId(context, searchText);

    // ignore: use_build_context_synchronously
    Navigator.pushNamed(
      context,
      AppRoutes.recommendationScreen,
      arguments: {
        'searchText': searchText,
        'searchId': searchId,
      },
    );
  }
}
