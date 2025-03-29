import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroceryListScreen extends StatefulWidget {
  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<String> groceryList = [];
  TextEditingController _ingredientController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadGroceryList();
  }

  // Load the grocery list from SharedPreferences
  Future<void> loadGroceryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      groceryList = prefs.getStringList('groceryList') ?? [];
    });
  }

  // Add a new ingredient to the grocery list
  Future<void> addIngredient() async {
    String newIngredient = _ingredientController.text.trim();
    if (newIngredient.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!groceryList.contains(newIngredient)) {
        groceryList.add(newIngredient);
        await prefs.setStringList('groceryList', groceryList);
        _ingredientController.clear();
        loadGroceryList(); // Refresh the list
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$newIngredient added to grocery list')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$newIngredient is already in the list')),
        );
      }
    }
  }

  // Remove an ingredient from the grocery list
  Future<void> removeIngredient(String ingredient) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      groceryList.remove(ingredient);
    });
    await prefs.setStringList('groceryList', groceryList); // Save updated list to SharedPreferences
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$ingredient removed from grocery list')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField to add a new ingredient
            TextField(
              controller: _ingredientController,
              decoration: InputDecoration(
                labelText: "Enter ingredient",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addIngredient,
                ),
              ),
            ),
            SizedBox(height: 20),
            // List of ingredients
            Expanded(
              child: ListView.builder(
                itemCount: groceryList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(groceryList[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeIngredient(groceryList[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
