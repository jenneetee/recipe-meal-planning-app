import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  final List<String> ingredients;

  GroceryListScreen({required this.ingredients});

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  late List<String> groceryList;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    groceryList = List.from(widget.ingredients);
  }

  void _addIngredient() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        groceryList.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _removeIngredient(String ingredient) {
    setState(() {
      groceryList.remove(ingredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery List")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Add an ingredient...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addIngredient,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: groceryList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(groceryList[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeIngredient(groceryList[index]),
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
