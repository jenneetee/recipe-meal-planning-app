import 'package:flutter/material.dart';
import 'grocery_list.dart';  // Import GroceryListScreen

class RecipeDetailScreen extends StatefulWidget {
  final String recipeName;
  final List<String> ingredients;
  final String instructions;
  final String imagePath;
  final List<String> labels;

  RecipeDetailScreen({
    required this.recipeName,
    required this.ingredients,
    required this.instructions,
    required this.imagePath,
    required this.labels,
  });

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  Map<String, bool> checkedItems = {};

  @override
  void initState() {
    super.initState();
    // Initialize checkbox state for each ingredient
    for (var ingredient in widget.ingredients) {
      checkedItems[ingredient] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipeName)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.recipeName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: widget.labels.map((label) => Chip(label: Text(label))).toList(),
            ),
            SizedBox(height: 10),
            Text(
              "Ingredients",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Ingredients List with Checkbox
            Column(
              children: widget.ingredients.map((ingredient) {
                return CheckboxListTile(
                  title: Text(ingredient),
                  value: checkedItems[ingredient],
                  onChanged: (bool? value) {
                    setState(() {
                      checkedItems[ingredient] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Collect the checked ingredients and pass them to the grocery list screen
                List<String> groceryList = widget.ingredients.where((ingredient) {
                  return checkedItems[ingredient] ?? false;
                }).toList();
                if (groceryList.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroceryListScreen(
                        ingredients: groceryList,
                      ),
                    ),
                  );
                }
              },
              child: Text("Add to Grocery List"),
            ),
            SizedBox(height: 10),
            Text(
              "Directions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(widget.instructions),
          ],
        ),
      ),
    );
  }
}
