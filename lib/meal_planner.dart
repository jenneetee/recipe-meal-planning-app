import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
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
    _loadMealPlan();
  }

  Future<void> _loadMealPlan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var day in days) {
        String? data = prefs.getString(day);
        if (data != null) {
          List<dynamic> storedMeals = jsonDecode(data);
          mealPlan[day] = storedMeals.map((meal) => {
            "recipe": meal["recipe"],
            "time": TimeOfDay(hour: meal["time"]["hour"], minute: meal["time"]["minute"]),
          }).toList();
        } else {
          mealPlan[day] = [];
        }
      }
    });
  }

  Future<void> _saveMealPlan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var day in days) {
      List<Map<String, dynamic>> meals = mealPlan[day]!;
      List<Map<String, dynamic>> storedMeals = meals.map((meal) => {
        "recipe": meal["recipe"],
        "time": {"hour": meal["time"].hour, "minute": meal["time"].minute},
      }).toList();
      await prefs.setString(day, jsonEncode(storedMeals));
    }
  }

  void _addMealToDay(Map<String, dynamic> recipe, TimeOfDay time) {
    setState(() {
      mealPlan[days[selectedDay]]!.add({"recipe": recipe, "time": time});
      mealPlan[days[selectedDay]]!.sort((a, b) =>
          a["time"].hour.compareTo(b["time"].hour) == 0
              ? a["time"].minute.compareTo(b["time"].minute)
              : a["time"].hour.compareTo(b["time"].hour));
    });
    _saveMealPlan(); // Save to local storage
  }

  void _removeMealFromDay(int index) {
    setState(() {
      mealPlan[days[selectedDay]]!.removeAt(index);
    });
    _saveMealPlan(); // Save to local storage
  }

  void _showRecipeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: widget.recipes.map((recipe) {
            return ListTile(
              title: Text(recipe['name']),
              onTap: () async {
                Navigator.pop(context);
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  _addMealToDay(recipe, selectedTime);
                }
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
                      color: selectedDay == index
                          ? Colors.grey[800]
                          : Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(days[index], style: TextStyle(color: Colors.white)),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mealPlan[days[selectedDay]]!.length,
              itemBuilder: (context, index) {
                final meal = mealPlan[days[selectedDay]]![index];
                return MealTile(
                  time: meal['time'],
                  meal: meal['recipe']['name'],
                  onDelete: () => _removeMealFromDay(index),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: _showRecipeSelector,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}

class MealTile extends StatelessWidget {
  final TimeOfDay time;
  final String meal;
  final VoidCallback onDelete;

  MealTile({required this.time, required this.meal, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.food_bank),
        title: Text(meal),
        subtitle: Text("Time: ${time.format(context)}"),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
