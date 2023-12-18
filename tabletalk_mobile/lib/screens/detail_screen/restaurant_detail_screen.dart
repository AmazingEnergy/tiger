import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/restaurant_detail.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/services/review_rating_service.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final RestaurantDetail restaurantDetail;
  const RestaurantDetailScreen({required this.restaurantDetail, super.key});

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  late double currentRating;
  bool isStarRated = false;

  @override
  void initState() {
    super.initState();
    currentRating = widget.restaurantDetail.inAppRating;
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _buildCardSection(context, widget.restaurantDetail),
                Positioned(
                  top: 16.0,
                  left: 16.0,
                  child: _buildBackButton(context),
                ),
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: _buildRatingBar(),
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 35.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFiveSection(context, widget.restaurantDetail),
                  SizedBox(height: 25.v),
                  Container(
                    width: 295.h,
                    margin: EdgeInsets.only(left: 30.h, right: 49.h),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Address:  ",
                            style:
                                CustomTextStyles.bodyMediumBlack900_1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "${widget.restaurantDetail.address}\r",
                            style: CustomTextStyles.bodyMediumBlack900_1,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 25.v),
                  _buildOneSection(context, widget.restaurantDetail),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSection(BuildContext context, RestaurantDetail restaurant) {
    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.only(top: 20.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 200.v,
          width: double.infinity,
          child: CustomImageView(
            imagePath: getImageUrl(restaurant.imageUrl),
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildFiveSection(BuildContext context, RestaurantDetail restaurant) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
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
              launchWebsite(widget.restaurantDetail.website);
            },
          ),
        ],
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
        height: 500.v,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.network(
              staticMapUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30.h, bottom: 37.v),
                child: Text("Google", style: theme.textTheme.titleLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: RatingBar.builder(
          initialRating: currentRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30.0,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              currentRating = rating;
              isStarRated = true;
            });
            _saveRating(currentRating);
          },
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: () {
          onTapImgArrowLeft(context);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowLeft,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
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
    const zoom = '18';
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

  void _saveRating(double rating) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.credentials == null) {
      authProvider.loginAction(context);
    }
    final String accessToken = authProvider.credentials!.accessToken;

    ReviewRatingService reviewRatingService =
        ReviewRatingService(accessToken: accessToken);

    if (rating == 0.0) {
      try {
        await reviewRatingService.createRating(
            widget.restaurantDetail.id, "restaurant", rating);
      } catch (e) {
        await reviewRatingService.updateRating(
            widget.restaurantDetail.id, rating);
      }
    } else {
      try {
        await reviewRatingService.updateRating(
            widget.restaurantDetail.id, rating);
      } catch (e) {
        await reviewRatingService.createRating(
            widget.restaurantDetail.id, "restaurant", rating);
      }
    }
  }

  void onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
