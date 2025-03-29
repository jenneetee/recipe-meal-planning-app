import 'package:flutter/material.dart';

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
  Map<String, bool> ingredientCheckStatus = {};
  List<String> groceryList = [];

  @override
  void initState() {
    super.initState();
    for (var ingredient in widget.ingredients) {
      ingredientCheckStatus[ingredient] = false;
    }
  }

  void toggleIngredientCheck(String ingredient, bool? value) {
    setState(() {
      ingredientCheckStatus[ingredient] = value ?? false;
    });
  }

  void addToGroceryList(String ingredient) {
    if (!groceryList.contains(ingredient)) {
      setState(() {
        groceryList.add(ingredient);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$ingredient added to grocery list')),
      );
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
            Text(widget.recipeName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: widget.labels
                  .map((label) => Chip(label: Text(label)))
                  .toList(),
            ),
            SizedBox(height: 10),
            Text("Ingredients",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              children: widget.ingredients.map((ingredient) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(ingredient),
                        value: ingredientCheckStatus[ingredient],
                        onChanged: (value) =>
                            toggleIngredientCheck(ingredient, value),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () => addToGroceryList(ingredient),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text("Directions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(widget.instructions),
          ],
        ),
      ),
    );
  }
}
