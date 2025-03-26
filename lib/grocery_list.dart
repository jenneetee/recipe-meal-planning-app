import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<String> ingredients = [
    "Milk",
    "Bread",
    "Peanut Butter",
    "Lettuce",
    "Tomato"
  ];
  final Map<String, bool> checkedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery List")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                String ingredient = ingredients[index];
                return CheckboxListTile(
                  title: Text(ingredient),
                  value: checkedItems[ingredient] ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      checkedItems[ingredient] = value!;
                    });
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {}, // Future: Add ingredient functionality
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
