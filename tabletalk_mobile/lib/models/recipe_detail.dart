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
}

class Instruction {
  final int step;
  final String description;

  Instruction({
    required this.step,
    required this.description,
  });
}
