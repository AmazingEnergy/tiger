import 'package:tabletalk_mobile/models/recipe_detail.dart';

final recipes = [
  RecipeDetail(
    id: "dfd824b0-375e-4820-b085-7e75ef56a82c",
    name: "Chicken Parmesan",
    time: 30,
    author: "John Doe",
    imageUrl: "https://via.placeholder.com/150",
    ingredients: [
      "1/2 cup Italian seasoned bread crumbs",
      "1/4 cup grated Parmesan cheese",
      "4 skinless, boneless chicken breast halves",
      "1 egg",
      "1/2 cup milk",
      "1/4 cup vegetable oil",
      "2 cups spaghetti sauce",
      "1/2 cup shredded mozzarella cheese",
      "rice",
      "rice",
      "rice",
      "rice",
      "rice",
    ],
    instructions: [
      Instruction(step: 1, description: "Preheat oven to 350 degrees"),
      Instruction(
          step: 2,
          description: "Mix bread crumbs and Parmesan cheese in a bowl"),
      Instruction(
          step: 3,
          description: "Dip chicken in egg and then in bread crumb mixture"),
      Instruction(step: 4, description: "Place chicken on a baking sheet"),
      Instruction(step: 5, description: "Bake for 20 minutes"),
      Instruction(step: 6, description: "Bake for 20 minutes"),
      Instruction(step: 7, description: "Bake for 20 minutes"),
    ],
  ),
];
