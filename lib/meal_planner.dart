// meal_planner.dart (updated)
import 'package:flutter/material.dart';
import 'grocery_list.dart';
import 'home_screen.dart';

class MealPlannerScreen extends StatefulWidget {
  final List<Map<String, dynamic>> recipes;
  MealPlannerScreen({required this.recipes});

  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final List<String> days = ["Fri 7th", "Sat 8th", "Sun 9th", "Mon 10th", "Tue 11th"];
  int selectedDay = 0;
  Map<String, List<Map<String, dynamic>>> mealPlan = {};

  @override
  void initState() {
    super.initState();
    for (var day in days) {
      mealPlan[day] = [];
    }
  }

  void _addMealToDay(Map<String, dynamic> recipe) {
    setState(() {
      mealPlan[days[selectedDay]]!.add(recipe);
    });
  }

  void _generateGroceryList() {
    Set<String> ingredients = {};
    for (var meals in mealPlan.values) {
      for (var meal in meals) {
        ingredients.addAll(List<String>.from(meal['ingredients']));
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroceryListScreen(ingredients: ingredients.toList()),
      ),
    );
  }

  void _showRecipeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: widget.recipes.map((recipe) {
            return ListTile(
              title: Text(recipe['name']),
              onTap: () {
                Navigator.pop(context);
                _addMealToDay(recipe);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meal Planner")),
      body: Column(
        children: [
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(days.length, (index) {
                return GestureDetector(
                  onTap: () => setState(() => selectedDay = index),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: selectedDay == index ? Colors.grey[800] : Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(days[index], style: TextStyle(color: Colors.white)),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView(
              children: mealPlan[days[selectedDay]]!.map((meal) {
                return MealTile(time: "", meal: meal['name'], dish: "");
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: _showRecipeSelector,
                child: Icon(Icons.add),
              ),
              ElevatedButton(
                onPressed: _generateGroceryList,
                child: Text("Generate Grocery List"),
              )
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}

class MealTile extends StatelessWidget {
  final String time;
  final String meal;
  final String dish;

  MealTile({required this.time, required this.meal, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.food_bank),
        title: Text(meal),
        subtitle: Text(dish),
      ),
    );
  }
}
