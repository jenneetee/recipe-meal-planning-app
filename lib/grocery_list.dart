import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  final List<String> ingredients;

  GroceryListScreen({required this.ingredients});

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  late List<String> groceryItems;

  @override
  void initState() {
    super.initState();
    groceryItems = List.from(widget.ingredients);
  }

  void _removeItem(int index) {
    setState(() {
      groceryItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery List")),
      body: groceryItems.isEmpty
          ? Center(child: Text("No items in the grocery list"))
          : ListView.builder(
              itemCount: groceryItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(groceryItems[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeItem(index),
                  ),
                );
              },
            ),
    );
  }
}