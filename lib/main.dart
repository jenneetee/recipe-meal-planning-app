// main.dart (updated)
import 'package:flutter/material.dart';
import 'meal_planner.dart';
import 'grocery_list.dart';
import 'recipe_detail.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Planner App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> recipes = [
    {
      "name": "Veggie Wrap",
      "image": "assets/veggie_wrap.jpg",
      "ingredients": ["Tortilla", "Lettuce", "Tomato", "Avocado"],
      "instructions": "1. Wrap all ingredients in tortilla.\n2. Enjoy!",
      "labels": ["Vegan", "Vegetarian"]
    },
    {
      "name": "Pasta Primavera",
      "image": "assets/pasta_primavera.jpg",
      "ingredients": ["Pasta", "Bell Peppers", "Olive Oil", "Garlic"],
      "instructions": "1. Cook pasta.\n2. Sauté veggies.\n3. Mix and serve!",
      "labels": ["Vegetarian"]
    },
    {
      "name": "Chicken Stir Fry",
      "image": "assets/chicken_stir_fry.jpg",
      "ingredients": ["Chicken", "Soy Sauce", "Broccoli", "Carrots"],
      "instructions": "1. Cook chicken.\n2. Add veggies and stir-fry.\n3. Serve!",
      "labels": []
    },
    {
      "name": "Berry Smoothie",
      "image": "assets/berry_smoothie.jpg",
      "ingredients": ["Berries", "Banana", "Yogurt", "Honey"],
      "instructions": "1. Blend all ingredients.\n2. Pour and enjoy!",
      "labels": ["Vegetarian", "Gluten-Free"]
    },
  ];

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),
      MealPlannerScreen(recipes: recipes),
      GroceryListScreen(ingredients: []), // fallback
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Meal Planner"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Grocery List"),
        ],
      ),
    );
  }
}
