class RecipeDetail {
  final String id;
  final String name;
  final int time;
  final String author;
  final String imageUrl;
  final List<String> ingredients;
  final List<Instruction> instructions;
  final double inAppRating;

  RecipeDetail({
    required this.id,
    required this.name,
    required this.time,
    required this.author,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.inAppRating,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      time: int.tryParse(json['time'].toString()) ?? 0,
      author: json['author'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: _parseInstructions(json['instructions']),
      inAppRating: json['inAppRating'] != null
          ? double.parse(json['inAppRating'].toString())
          : 0.0,
    );
  }

  static List<Instruction> _parseInstructions(List<dynamic>? instructions) {
    return List<Instruction>.from(
      instructions?.map(
            (instruction) => Instruction(
              step: instruction['step'].toString(),
              description: instruction['description'] ?? '',
            ),
          ) ??
          [],
    );
  }
}

class Instruction {
  final String step;
  final String description;

  Instruction({
    required this.step,
    required this.description,
  });
}
