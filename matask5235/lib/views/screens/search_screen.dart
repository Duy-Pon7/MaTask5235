import 'package:flutter/material.dart';
import 'package:matask5235/models/meal.dart';
import 'package:matask5235/viewmodels/resources/meal_api.dart';
import 'package:matask5235/views/screens/detail_screen.dart';
import 'package:matask5235/views/widgets/bottom_sheets/categoryfiltersheet.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Meal> meals = [];
  String searchText = 'Arrabiata';

  final TextEditingController controller = TextEditingController(
    text: 'Arrabiata',
  );

  void fetchMeals(String keyword) async {
    final result = await MealApi.searchMeals(keyword);
    setState(() {
      meals = result;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMeals(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: controller,
          onSubmitted: (value) {
            fetchMeals(value);
          },
          decoration: InputDecoration(
            hintText: 'Tìm món ăn...',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt, color: Colors.grey),
            onPressed: () async {
              final selected =
                  await showModalBottomSheet<Map<String, String?>>(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    builder: (context) => CategoryFilterSheet(),
                  );

              if (selected != null) {
                print('Selected Category: ${selected['category']}');
                print('Selected Area: ${selected['area']}');
                print(
                  'Selected Ingredient: ${selected['ingredient']}',
                );

                // Gợi ý: Thêm logic để lọc danh sách meal theo selected (nếu muốn).
              }
            },
          ),
        ],
      ),
      body:
          meals.isEmpty
              ? Center(child: Text('Không tìm thấy món ăn.'))
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: meals.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.8,
                      ),
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return ProductCard(meal: meal);
                  },
                ),
              ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Meal meal;

  const ProductCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(meal: meal),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Image.network(
                  meal.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meal.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
