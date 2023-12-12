import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/restaurant_detail.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantDetail restaurantDetail;
  RestaurantDetailScreen({required this.restaurantDetail, super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Stack(
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 35.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.v),
                    CustomImageView(
                      imagePath: ImageConstant.imgArrowLeft,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                      margin: EdgeInsets.only(left: 30.h),
                      onTap: () {
                        onTapImgArrowLeft(context);
                      },
                    ),
                    SizedBox(height: 10.v),
                    _buildCardSection(context, restaurantDetail),
                    SizedBox(height: 10.v),
                    _buildFiveSection(context, restaurantDetail),
                    SizedBox(height: 25.v),
                    Container(
                      width: 295.h,
                      margin: EdgeInsets.only(left: 30.h, right: 49.h),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Address:  ",
                              style: CustomTextStyles.bodyMediumBlack900_1
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "${restaurantDetail.address}\r",
                              style: CustomTextStyles.bodyMediumBlack900_1,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 25.v),
                    _buildOneSection(context, restaurantDetail),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardSection(BuildContext context, RestaurantDetail restaurant) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 150.v,
        width: 315.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: getImageUrl(restaurant.imageUrl),
              height: 400.v,
              width: 300.h,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiveSection(BuildContext context, RestaurantDetail restaurant) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${restaurant.name}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.v),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFFFE1B3),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0XFFFFAD30),
                          size: 16,
                        ),
                        SizedBox(width: 4.h),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.v),
                  Text("Food restaurant", style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            CustomElevatedButton(
              height: 33.v,
              width: 143.h,
              text: "Visit Website",
              isDisabled: restaurant.website == '',
              margin: EdgeInsets.only(left: 13.h, top: 13.v, bottom: 14.v),
              buttonStyle: CustomButtonStyles.none,
              decoration: CustomButtonStyles.gradientPinkToPinkADecoration,
              buttonTextStyle: CustomTextStyles.labelMediumWhiteA700,
              onPressed: () {
                launchWebsite(restaurant.website);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOneSection(BuildContext context, RestaurantDetail restaurant) {
    String staticMapUrl = generateStaticMapUrl(restaurant.address);

    return GestureDetector(
      onTap: () {
        launchGoogleMap(restaurant.address);
      },
      child: SizedBox(
        height: 300.v,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.network(
              staticMapUrl,
              height: 295.v,
              width: 375.h,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.h, bottom: 37.v),
                child: Text("Google", style: theme.textTheme.titleLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getImageUrl(String photoReference, {int maxWidth = 400}) {
    var apiKey = dotenv.env['GOOGLE_API_KEY'];
    final url = "https://maps.googleapis.com/maps/api/place/photo"
        "?maxwidth=$maxWidth"
        "&photoreference=$photoReference"
        "&key=$apiKey";

    return url;
  }

  String generateStaticMapUrl(String address) {
    var apiKey = dotenv.env['GOOGLE_API_KEY'];
    final encodedAddress = Uri.encodeComponent(address);
    final marker = 'markers=color:red%7Clabel:A%7C$encodedAddress';
    const zoom = '20';
    const size = '1000x1000';

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$encodedAddress&zoom=$zoom&size=$size&$marker&key=$apiKey';
  }

  Future<void> launchGoogleMap(String address) async {
    try {
      await MapsLauncher.launchQuery(address);
    } catch (e) {
      throw 'Could not launch map $e';
    }
  }

  Future<void> launchWebsite(String website) async {
    final Uri url = Uri.parse(website);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
