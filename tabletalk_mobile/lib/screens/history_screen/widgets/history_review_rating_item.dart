// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/widgets/custom_rating_bar.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/simple_rating_model.dart';
import 'package:tabletalk_mobile/services/review_rating_service.dart';

class HistoryReviewRatingItem extends StatelessWidget {
  final SimpleRatingModel rating;
  final VoidCallback onRatingUpdated;

  const HistoryReviewRatingItem(
      {super.key, required this.rating, required this.onRatingUpdated});

  @override
  Widget build(BuildContext context) {
    String imageUrl = rating.rateFor == RateFor.restaurant
        ? getImageUrl(rating.imageUrl)
        : rating.imageUrl;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.v),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 25.h,
          ),
          SizedBox(width: 8.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${rating.name} - ${rating.rateFor.string}",
                  style: CustomTextStyles.labelLargeGray800,
                ),
                CustomRatingBar(
                  initialRating: rating.rating,
                  viewOnly: true,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showRatingEditDialog(context, rating);
            },
          ),
        ],
      ),
    );
  }

  void _showRatingEditDialog(BuildContext context, SimpleRatingModel rating) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double newRating = rating.rating;
        return AlertDialog(
          title: const Text("Edit Rating"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select a new rating:"),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: rating.rating,
                minRating: 1,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (value) {
                  newRating = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Update"),
              onPressed: () async {
                try {
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  if (authProvider.credentials == null) {
                    authProvider.loginAction(context);
                    return;
                  }
                  final String accessToken =
                      authProvider.credentials!.accessToken;
                  ReviewRatingService reviewRatingService =
                      ReviewRatingService(accessToken: accessToken);

                  await reviewRatingService.updateRating(rating.id, newRating);
                  Navigator.of(context).pop();

                  onRatingUpdated();

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Rating updated successfully!")));
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Failed to update rating: $e")));
                }
              },
            ),
          ],
        );
      },
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
}
