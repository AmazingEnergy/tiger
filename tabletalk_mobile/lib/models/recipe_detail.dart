class RecipeDetail {
  final String id;
  final String name;
  final int time;
  final String author;
  final String imageUrl;
  final List<String> ingredients;
  final List<Instruction> instructions;

  RecipeDetail({
    required this.id,
    required this.name,
    required this.time,
    required this.author,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      time: json['time'] ?? 0,
      author: json['author'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: _parseInstructions(json['instructions']),
    );
  }

  static List<Instruction> _parseInstructions(List<dynamic>? instructions) {
    return List<Instruction>.from(
      instructions?.map(
            (instruction) => Instruction(
              step: instruction['step'] ?? 0,
              description: instruction['description'] ?? '',
            ),
          ) ??
          [],
    );
  }
}

class Instruction {
  final int step;
  final String description;

  Instruction({
    required this.step,
    required this.description,
  });
}
