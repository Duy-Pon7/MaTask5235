class Category {
  final String name;
  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(name: json['strCategory']);
}

class Area {
  final String name;
  Area({required this.name});

  factory Area.fromJson(Map<String, dynamic> json) =>
      Area(name: json['strArea']);
}

class Ingredient {
  final String name;
  Ingredient({required this.name});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      Ingredient(name: json['strIngredient']);
}
