import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matask5235/models/meal.dart';

Future<List<Meal>> fetchMeals() async {
  final response = await http.get(
    Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/search.php?f=a',
    ),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List meals = data['meals'];
    return meals.map((json) => Meal.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load meals');
  }
}
