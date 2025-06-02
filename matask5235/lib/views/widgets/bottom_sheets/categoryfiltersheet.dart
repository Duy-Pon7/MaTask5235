import 'package:flutter/material.dart';
import 'package:matask5235/models/category.dart';
import 'package:matask5235/viewmodels/resources/filter_api.dart';

class CategoryFilterSheet extends StatefulWidget {
  @override
  _CategoryFilterSheetState createState() =>
      _CategoryFilterSheetState();
}

class _CategoryFilterSheetState extends State<CategoryFilterSheet> {
  List<Category> categories = [];
  List<Area> areas = [];
  List<Ingredient> ingredients = [];

  String? selectedCategory;
  String? selectedArea;
  String? selectedIngredient;

  @override
  void initState() {
    super.initState();
    loadFilters();
  }

  void loadFilters() async {
    final fetchedCategories = await FilterApi.fetchCategories();
    final fetchedAreas = await FilterApi.fetchAreas();
    final fetchedIngredients = await FilterApi.fetchIngredients();

    setState(() {
      categories = fetchedCategories;
      areas = fetchedAreas;
      ingredients = fetchedIngredients;
    });
  }

  Widget buildFilterSection<T>(
    String title,
    List<T> items,
    String? selectedItem,
    Function(String?) onSelected,
    String Function(T) getLabel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              items.map((item) {
                final label = getLabel(item);
                final isSelected = label == selectedItem;
                return ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  selectedColor: Colors.amber[700],
                  onSelected: (_) => onSelected(label),
                );
              }).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = null;
                          selectedArea = null;
                          selectedIngredient = null;
                        });
                      },
                      child: Text("Đặt lại"),
                    ),
                  ],
                ),
                buildFilterSection<Category>(
                  'Danh mục',
                  categories,
                  selectedCategory,
                  (value) => setState(() => selectedCategory = value),
                  (c) => c.name,
                ),
                buildFilterSection<Ingredient>(
                  'Nguyên liệu',
                  ingredients
                      .take(10)
                      .toList(), // Hiển thị 10 nguyên liệu
                  selectedIngredient,
                  (value) =>
                      setState(() => selectedIngredient = value),
                  (i) => i.name,
                ),
                buildFilterSection<Area>(
                  'Khu vực',
                  areas,
                  selectedArea,
                  (value) => setState(() => selectedArea = value),
                  (a) => a.name,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'category': selectedCategory,
                      'area': selectedArea,
                      'ingredient': selectedIngredient,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[700],
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Xác nhận'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
