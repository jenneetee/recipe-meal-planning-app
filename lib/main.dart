// main.dart
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
      theme: ThemeData(
        primaryColor: Color(0xFF606C38),
        scaffoldBackgroundColor: Color(0xFFFEFAE0),
        appBarTheme: AppBarTheme(
          color: Color(0xFF283618),
          iconTheme: IconThemeData(color: Color(0xFFFEFAE0)),
          titleTextStyle: TextStyle(
              color: Color(0xFFFEFAE0),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFBC6C25),
          foregroundColor: Color(0xFFFEFAE0),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF283618),
          selectedItemColor: Color(0xFFDDA15E),
          unselectedItemColor: Color(0xFFBC6C25),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF283618)),
          bodyMedium: TextStyle(color: Color(0xFF283618)),
          titleLarge: TextStyle(color: Color(0xFF606C38)),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFDDA15E),
          textTheme: ButtonTextTheme.primary,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Color(0xFFBC6C25),
          labelStyle: TextStyle(color: Colors.white),
          selectedColor: Color(0xFFDDA15E),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFDDA15E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Color(0xFF283618)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFDDA15E),
            foregroundColor: Color(0xFF283618),
          ),
        ),
        cardTheme: CardTheme(
          color: Color(0xFFFEFAE0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0xFF606C38), width: 2),
          ),
        ),
      ),
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
      "name": "Turkey Sandwich",
      "image": "assets/sub.jpg",
      "ingredients": ["Whole wheat bread", "Sliced turkey", "Lettuce", "Tomato", "Mayonnaise", "Mustard", "Cheese (optional)"],
      "instructions": "1. Toast the bread slices if desired.\n2. Spread mayonnaise and mustard on one or both slices of bread.\n3. Layer the sliced turkey evenly on one slice of bread.\n4. Add lettuce, tomato slices, and cheese if using.\n5. Place the second slice of bread on top and press gently.\n6. Cut the sandwich in half and serve immediately.",
      "labels": []
    },
    {
      "name": "Pasta",
      "image": "assets/pasta.jpg",
      "ingredients": ["Pasta", "Bell Peppers", "Olive Oil", "Garlic"],
      "instructions": "1. Bring a large pot of salted water to a boil and cook the pasta according to package instructions until al dente. Drain and set aside.\n2. In a large pan, heat olive oil over medium heat. Add minced garlic and sauté until fragrant.\n3. Add bell peppers and other desired vegetables, cooking for 5-7 minutes until tender yet slightly crisp.\n4. Toss in the cooked pasta and mix well, ensuring the vegetables and flavors are evenly distributed.\n5. Season with salt, pepper, and a sprinkle of Parmesan cheese if desired.",
      "labels": ["Vegetarian"]
    },
    {
        "name": "Yogurt with Granola & Berries",
        "image": "assets/yogurt.jpg",
        "ingredients": ["Greek Yogurt", "Granola", "Strawberries", "Blueberries", "Honey"],
        "instructions": "1. In a bowl, add a generous serving of Greek yogurt.\n2. Sprinkle a handful of granola over the yogurt for crunch.\n3. Top with fresh strawberries and blueberries for natural sweetness.\n4. Drizzle honey on top for added flavor.\n5. Mix gently or enjoy as layers, and serve immediately!",
        "labels": ["Vegetarian", "Gluten-Free"]
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
      GroceryListScreen(ingredients: []),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Meal Planner"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Grocery List"),
        ],
      ),
    );
  }
}
