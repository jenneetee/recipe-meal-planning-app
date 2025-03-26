import 'package:flutter/material.dart';

class MealPlannerScreen extends StatefulWidget {
  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final List<String> days = [
    "Fri 7th",
    "Sat 8th",
    "Sun 9th",
    "Mon 10th",
    "Tue 11th"
  ];
  int selectedDay = 1; // Default selection

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
                      color: selectedDay == index
                          ? Colors.grey[800]
                          : Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      days[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                MealTile(time: "9:15AM", meal: "Breakfast", dish: "Cereal"),
                MealTile(time: "12:00PM", meal: "Lunch", dish: "PB&J Sandwich"),
                MealTile(time: "6:30PM", meal: "Dinner", dish: "Veggie Wrap"),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {}, // Future: Add meal functionality
            child: Icon(Icons.add),
          ),
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
        title: Text("$time - $meal"),
        subtitle: Text(dish),
      ),
    );
  }
}
