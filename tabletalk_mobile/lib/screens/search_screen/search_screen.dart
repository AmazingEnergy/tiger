// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/search_id_model.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/screens/recommendation_screen/recommendation_screen.dart';
import 'package:tabletalk_mobile/services/search_id_data_service.dart';
import 'package:tabletalk_mobile/services/user_profile_service.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool loading = false;
  TextEditingController askController = TextEditingController();
  String _membership = 'normal';
  int _searchCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      loading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.credentials == null) {
        authProvider.loginAction(context);
      }
      final String accessToken = authProvider.credentials!.accessToken;

      UserProfileService userProfileService =
          UserProfileService(accessToken: accessToken);
      var userProfile = await userProfileService.getProfile();

      setState(() {
        _membership = userProfile.membership;
        _searchCount = int.tryParse(userProfile.searchCount) ?? 0;
        loading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user profile: ${e}')),
      );
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    bool isLimited = (_membership == 'pro' && _searchCount >= 10) ||
        (_membership != 'pro' && _searchCount >= 2);
    String hintText = isLimited
        ? "You have reached the search limit for today!"
        : "Ask us anything!";

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                    Text('Searches today: $_searchCount'),
                    loading
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              CustomTextFormField(
                                controller: askController,
                                hintText: hintText,
                                textInputAction: TextInputAction.done,
                                enabled: (_membership == 'pro' &&
                                        _searchCount < 10) ||
                                    (_membership != 'pro' && _searchCount < 2),
                              ),
                              SizedBox(height: 3.v),
                              CustomElevatedButton(
                                height: 45.h,
                                buttonTextStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15,
                                ),
                                text: "Submit",
                                isDisabled: !(_membership == 'pro' &&
                                        _searchCount < 10) ||
                                    (_membership != 'pro' && _searchCount < 2),
                                onPressed: loading
                                    ? null
                                    : () {
                                        String searchText = askController.text;
                                        if (searchText.isNotEmpty && !loading) {
                                          _submitSearch(context, searchText);
                                        }
                                      },
                                buttonStyle: CustomButtonStyles.none,
                                decoration: CustomButtonStyles
                                    .gradientPrimaryToOnPrimaryContainerDecoration,
                              ),
                            ],
                          ),
                    SizedBox(height: 5.v),
                    loading
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getSearchId(BuildContext context, String searchText) async {
    final capturedContext = context;
    SearchIdModel searchId;
    final authProvider =
        Provider.of<AuthProvider>(capturedContext, listen: false);
    if (authProvider.credentials != null) {
      final String accessToken = authProvider.credentials!.accessToken;

      SearchIdDataService searchIdDataService =
          SearchIdDataService(accessToken: accessToken);

      searchId = await searchIdDataService.fetchSearchIdModels(searchText);
    } else {
      throw Exception('Failed to load data');
    }

    return searchId.id;
  }

  Future<void> _submitSearch(BuildContext context, String searchText) async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      loading = true;
    });

    try {
      String searchId = await getSearchId(context, searchText);

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecommendScreen(
            searchText: searchText,
            searchId: searchId,
          ),
        ),
      );
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Error: ${e.toString()}'),
        duration: const Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
