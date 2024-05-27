import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = '';
const apiUrl = 'https://api.openai.com/v1/chat/completions';

class Recipe extends StatefulWidget {
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  List<String> selectedIngredients = [];
  List<Map<String, String>> savedRecipes = [];

  void updateSelectedIngredients(String ingredient, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedIngredients.add(ingredient);
      } else {
        selectedIngredients.remove(ingredient);
      }
    });
  }

  void toggleSavedRecipe(String title, String image) {
    setState(() {
      final existingRecipeIndex =
          savedRecipes.indexWhere((recipe) => recipe['title'] == title);
      if (existingRecipeIndex >= 0) {
        savedRecipes.removeAt(existingRecipeIndex);
      } else {
        savedRecipes.add({'title': title, 'image': image});
      }
    });
  }

  bool isRecipeSaved(String title) {
    return savedRecipes.any((recipe) => recipe['title'] == title);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            '레시피 추천',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: "맞춤 레시피"),
              Tab(text: "재료 선택하기"),
            ],
            indicatorColor: Color(0xFF24AA5A),
            labelColor: Color(0xFF24AA5A), // 활성화된 탭 글씨 색상
            unselectedLabelColor: Colors.grey, // 비활성화된 탭 글씨 색상
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Center(
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  RecipeTile(
                    title: '토마토 달걀 볶음',
                    onTap: () async {
                      String recipe = await fetchRecipe('토마토 달걀 볶음');
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return RecipeDetailBottomSheet(
                              title: '토마토 달걀 볶음', recipe: recipe);
                        },
                      );
                    },
                    image: 'assets/tomato.png',
                  ),
                  SizedBox(height: 20),
                  RecipeTile(
                    title: '김치 잔치국수',
                    onTap: () async {
                      String recipe = await fetchRecipe('김치 잔치국수');
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return RecipeDetailBottomSheet(
                              title: '김치 잔치국수', recipe: recipe);
                        },
                      );
                    },
                    image: 'assets/kimchi.png',
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      children: [
                        IngredientIcon(
                          image: 'assets/tomato.png',
                          title: '토마토',
                          onSelected: updateSelectedIngredients,
                        ),
                        IngredientIcon(
                          image: 'assets/Carrot.png',
                          title: '당근',
                          onSelected: updateSelectedIngredients,
                        ),
                        IngredientIcon(
                          image: 'assets/Tomato(1).png',
                          title: '다른 토마토',
                          onSelected: updateSelectedIngredients,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (selectedIngredients.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('재료를 선택해주세요!'),
                              ),
                            );
                            return;
                          }
                          String recipe = await fetchRecipeForIngredients(
                              selectedIngredients);
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return RecipeDetailBottomSheet(
                                title: '추천된 레시피',
                                recipe: recipe,
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF24AA5A),
                        ),
                        child: Text('추천해주세요!'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeTile extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final String image;

  const RecipeTile({
    required this.title,
    required this.onTap,
    required this.image,
  });

  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: AssetImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
          child: ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              icon: isBookmarked
                  ? Icon(Icons.bookmark)
                  : Icon(Icons.bookmark_border),
              color: isBookmarked ? Colors.black : null,
              onPressed: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isBookmarked
                        ? '레시피를 마이페이지에 저장했습니다!'
                        : '레시피를 마이페이지에서 제거했습니다!'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class IngredientIcon extends StatefulWidget {
  final String image;
  final String title;
  final Function(String, bool) onSelected;

  const IngredientIcon({
    required this.image,
    required this.title,
    required this.onSelected,
  });

  @override
  _IngredientIconState createState() => _IngredientIconState();
}

class _IngredientIconState extends State<IngredientIcon> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onSelected(widget.title, isChecked);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: isChecked ? Colors.grey[300] : Colors.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: AssetImage(widget.image),
                radius: 40.0,
                backgroundColor: Colors.transparent,
              ),
            ),
            if (isChecked)
              Positioned(
                top: 8,
                left: 8,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailBottomSheet extends StatelessWidget {
  final String title;
  final String recipe;

  const RecipeDetailBottomSheet({
    required this.title,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(recipe),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchRecipe(String dishName) async {
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        'messages': [
          {"role": "system", "content": "You are a helpful assistant."},
          {"role": "user", "content": "I want a recipe for $dishName."},
        ],
        'max_tokens': 1000,
        'temperature': 0,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (responseBody['choices'] != null &&
          responseBody['choices'].isNotEmpty) {
        return responseBody['choices'][0]['message']['content'];
      } else {
        throw Exception("No response from GPT");
      }
    } else {
      throw Exception(
          "Failed to get response from GPT. Status Code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error in fetchRecipe: $e");
  }
}

Future<String> fetchRecipeForIngredients(
    List<String> selectedIngredients) async {
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        'messages': [
          {"role": "system", "content": "You are a helpful assistant."},
          {
            "role": "user",
            "content":
                "I want a recipe using ${selectedIngredients.join(', ')}."
          },
        ],
        'max_tokens': 1000,
        'temperature': 0,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (responseBody['choices'] != null &&
          responseBody['choices'].isNotEmpty) {
        return responseBody['choices'][0]['message']['content'];
      } else {
        throw Exception("No response from GPT");
      }
    } else {
      throw Exception(
          "Failed to get response from GPT. Status Code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error in fetchRecipeForIngredients: $e");
  }
}
