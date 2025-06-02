import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matask5235/models/meal.dart';

class MealApi {
  // Hàm hiện tại
  static Future<List<Meal>> searchMeals(String keyword) async {
    final url = Uri.parse(
      "https://www.themealdb.com/api/json/v1/1/search.php?s=$keyword",
    );
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    if (jsonData['meals'] == null) return [];

    return (jsonData['meals'] as List)
        .map((meal) => Meal.fromJson(meal))
        .toList();
  }

  // // Lấy danh sách danh mục
  // static Future<List<String>> fetchCategories() async {
  //   final response = await http.get(
  //     Uri.parse(
  //       'https://www.themealdb.com/api/json/v1/1/list.php?c=list',
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return List<String>.from(
  //       data['meals'].map((item) => item['strCategory']),
  //     );
  //   }
  //   return [];
  // }

  // static Future<List<String>> fetchIngredients() async {
  //   final response = await http.get(
  //     Uri.parse(
  //       'https://www.themealdb.com/api/json/v1/1/list.php?i=list',
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return List<String>.from(
  //       data['meals'].map((item) => item['strIngredient']),
  //     );
  //   }
  //   return [];
  // }

  // static Future<List<String>> fetchAreas() async {
  //   final response = await http.get(
  //     Uri.parse(
  //       'https://www.themealdb.com/api/json/v1/1/list.php?a=list',
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return List<String>.from(
  //       data['meals'].map((item) => item['strArea']),
  //     );
  //   }
  //   return [];
  // }

  static Future<Meal?> fetchMealDetail(String id) async {
    final url = Uri.parse(
      "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id",
    );
    final response = await http.get(url);
    final data = json.decode(response.body);
    if (data['meals'] == null) return null;

    return Meal.fromJson(data['meals'][0]);
  }
}
