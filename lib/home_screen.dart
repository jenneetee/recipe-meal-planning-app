import 'package:flutter/material.dart';
import 'recipe_detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  List<Map<String, dynamic>> displayedRecipes = [];
  List<Map<String, dynamic>> favoriteRecipes = [];
  String searchQuery = "";
  List<String> selectedFilters = [];
  final List<String> filters = ["Vegan", "Vegetarian", "Gluten-Free", "Dairy-Free"];

  @override
  void initState() {
    super.initState();
    displayedRecipes = recipes;
  }

  void updateSearchResults(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      displayedRecipes = recipes.where((recipe) {
        bool matchesQuery = recipe["name"].toLowerCase().contains(searchQuery);
        bool matchesFilters = selectedFilters.isEmpty ||
            selectedFilters.every((filter) => recipe["labels"].contains(filter));
        return matchesQuery && matchesFilters;
      }).toList();
    });
  }

  void toggleFilter(String filter) {
    setState(() {
      if (selectedFilters.contains(filter)) {
        selectedFilters.remove(filter);
      } else {
        selectedFilters.add(filter);
      }
      updateSearchResults(searchQuery);
    });
  }

  void toggleFavorite(Map<String, dynamic> recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meal Planner App")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: updateSearchResults,
              decoration: InputDecoration(
                hintText: "Search recipes...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: filters.map((filter) {
                return FilterChip(
                  label: Text(filter),
                  selected: selectedFilters.contains(filter),
                  onSelected: (isSelected) => toggleFilter(filter),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text("Favorites", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            favoriteRecipes.isEmpty
                ? Center(child: Text("No favorites yet"))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: favoriteRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = favoriteRecipes[index];
                      return ListTile(
                        title: Text(recipe["name"]),
                        leading: Image.asset(recipe["image"], width: 50, height: 50),
                        trailing: Icon(Icons.favorite, color: Colors.red),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailScreen(
                                recipeName: recipe["name"],
                                ingredients: List<String>.from(recipe["ingredients"]),
                                instructions: recipe["instructions"],
                                imagePath: recipe["image"],
                                labels: List<String>.from(recipe["labels"]),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: displayedRecipes.length,
              itemBuilder: (context, index) {
                final recipe = displayedRecipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(
                          recipeName: recipe["name"],
                          ingredients: List<String>.from(recipe["ingredients"]),
                          instructions: recipe["instructions"],
                          imagePath: recipe["image"],
                          labels: List<String>.from(recipe["labels"]),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(recipe["image"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            color: Colors.black54,
                            padding: EdgeInsets.all(4),
                            child: Text(
                              recipe["name"],
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              favoriteRecipes.contains(recipe)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: favoriteRecipes.contains(recipe)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                            onPressed: () {
                              toggleFavorite(recipe);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
