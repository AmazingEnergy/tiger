import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/models/api_sample_search_result.dart';

class RecipeBox extends StatelessWidget {
  final RecipeModel model;

  const RecipeBox({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(model.imageUrl ?? ""),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.info_outline,
                      color: Colors.white, size: 30),
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        model.name ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            model.author ?? "",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        const Icon(Icons.alarm, color: Colors.grey),
                        Text(
                          "${model.time}min",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
