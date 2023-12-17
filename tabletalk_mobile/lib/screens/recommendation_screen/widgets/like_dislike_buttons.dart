// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/services/search_id_data_service.dart';

class LikeDislikeButtons extends StatelessWidget {
  final String searchId;
  final Function() onActionCompleted;

  const LikeDislikeButtons({
    super.key,
    required this.searchId,
    required this.onActionCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: Row(
        children: [
          InkWell(
            onTap: () => handleLike(context),
            child: const CircleAvatar(
              radius: 28.0,
              backgroundColor: Color.fromRGBO(244, 136, 155, 0.8),
              child: Icon(Icons.thumb_up, color: Colors.white, size: 26.0),
            ),
          ),
          const SizedBox(width: 12.0),
          InkWell(
            onTap: () => handleDislike(context),
            child: const CircleAvatar(
              radius: 28.0,
              backgroundColor: Color.fromRGBO(244, 136, 155, 0.8),
              child: Icon(Icons.thumb_down, color: Colors.white, size: 26.0),
            ),
          ),
        ],
      ),
    );
  }

  void handleLike(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.credentials == null) {
        authProvider.loginAction(context);
        return;
      }
      final String accessToken = authProvider.credentials!.accessToken;
      SearchIdDataService service =
          SearchIdDataService(accessToken: accessToken);
      await service.putSatisfied(searchId);

      _showSnackbar(context, 'Liked!', Colors.green);
    } catch (e) {
      _showSnackbar(context, 'Failed to like: ${e.toString()}', Colors.red);
    }
  }

  void handleDislike(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.credentials == null) {
        authProvider.loginAction(context);
        return;
      }
      final String accessToken = authProvider.credentials!.accessToken;
      SearchIdDataService service =
          SearchIdDataService(accessToken: accessToken);
      await service.putDissatisfied(searchId);

      _showSnackbar(context, 'Disliked!', Colors.green);
    } catch (e) {
      _showSnackbar(context, 'Failed to dislike: ${e.toString()}', Colors.red);
    }
  }

  void _showSnackbar(BuildContext context, String message, Color bgColor) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
