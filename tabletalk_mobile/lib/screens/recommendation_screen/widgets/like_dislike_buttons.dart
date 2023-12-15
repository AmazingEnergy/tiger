import 'package:flutter/material.dart';

class LikeDislikeButtons extends StatelessWidget {
  final Function() onLike;
  final Function() onDislike;

  LikeDislikeButtons({required this.onLike, required this.onDislike});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: Row(
        children: [
          InkWell(
            onTap: onLike,
            child: const CircleAvatar(
              radius: 28.0,
              backgroundColor: Color.fromRGBO(244, 136, 155, 0.8),
              child: Icon(Icons.thumb_up, color: Colors.white, size: 26.0),
            ),
          ),
          const SizedBox(width: 12.0),
          InkWell(
            onTap: onDislike,
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
}
