import 'package:hive/hive.dart';

part 'meal.g.dart';

@HiveType(typeId: 0)
class Meal extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String instructions;

  @HiveField(3)
  final String thumbnail;

  @HiveField(4)
  final String youtube;

  @HiveField(5)
  final Map<String, String> ingredients;

  @HiveField(6)
  final String? category;

  @HiveField(7)
  final String? area;

  Meal({
    required this.id,
    required this.name,
    required this.instructions,
    required this.thumbnail,
    required this.youtube,
    required this.ingredients,
    this.category,
    this.area,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    Map<String, String> ingredients = {};
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().isNotEmpty &&
          measure != null &&
          measure.toString().isNotEmpty) {
        ingredients[ingredient] = measure;
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? 'Unknown Meal',
      instructions:
          json['strInstructions'] ?? 'No instructions available.',
      thumbnail: json['strMealThumb'] ?? '',
      youtube: json['strYoutube'] ?? '',
      ingredients: ingredients,
      category: json['strCategory'],
      area: json['strArea'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strInstructions': instructions,
      'strMealThumb': thumbnail,
      'strYoutube': youtube,
      'strCategory': category,
      'strArea': area,
      ...ingredients.map(
        (key, value) => MapEntry('strIngredient$key', value),
      ),
    };
  }
}
