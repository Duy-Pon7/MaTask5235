import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matask5235/models/category.dart';

class FilterApi {
  static Future<List<Category>> fetchCategories() async {
    final res = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/list.php?c=list',
      ),
    );
    final body = json.decode(res.body);
    return (body['meals'] as List)
        .map((e) => Category.fromJson(e))
        .toList();
  }

  static Future<List<Area>> fetchAreas() async {
    final res = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/list.php?a=list',
      ),
    );
    final body = json.decode(res.body);
    return (body['meals'] as List)
        .map((e) => Area.fromJson(e))
        .toList();
  }

  static Future<List<Ingredient>> fetchIngredients() async {
    final res = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/list.php?i=list',
      ),
    );
    final body = json.decode(res.body);
    return (body['meals'] as List)
        .map((e) => Ingredient.fromJson(e))
        .toList();
  }
}
