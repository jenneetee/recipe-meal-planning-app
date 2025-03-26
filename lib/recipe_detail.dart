import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeName;
  final List<String> ingredients;
  final String instructions;

  RecipeDetailScreen({
    required this.recipeName,
    required this.ingredients,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipeName)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              color: Colors.grey[300], // Placeholder for image
              child: Center(child: Icon(Icons.image, size: 50)),
            ),
            SizedBox(height: 10),
            Text(recipeName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Ingredients",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              children: ingredients.map((ingredient) {
                return CheckboxListTile(
                  title: Text(ingredient),
                  value: false,
                  onChanged: (bool? value) {},
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {}, // Future: Add to Grocery List
              child: Text("Add to Grocery List"),
            ),
            SizedBox(height: 10),
            Text("Directions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(instructions),
          ],
        ),
      ),
    );
  }
}
