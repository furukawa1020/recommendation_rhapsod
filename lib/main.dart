// lib/main.dart

import 'package:flutter/material.dart';

void main() {
  runApp(const RecommendationApp());
}

class RecommendationApp extends StatelessWidget {
  const RecommendationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recommendation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecommendationHomePage(),
    );
  }
}

class RecommendationHomePage extends StatefulWidget {
  const RecommendationHomePage({super.key});

  @override
  RecommendationHomePageState createState() => RecommendationHomePageState();
}

// クラス名の先頭にあるアンダースコアを削除し、パブリックに変更
class RecommendationHomePageState extends State<RecommendationHomePage> {
  final List<String> categories = ['Movies', 'Books', 'Music'];
  String selectedCategory = 'Movies';

  final Map<String, List<String>> recommendations = {
    'Movies': ['Inception', 'Interstellar', 'The Matrix'],
    'Books': ['1984', 'Brave New World', 'Fahrenheit 451'],
    'Music': ['Bohemian Rhapsody', 'Stairway to Heaven', 'Hotel California'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations for You'),
      ),
      body: Column(
        children: <Widget>[
          // Dropdown to select category
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
          // Display recommendations
          Expanded(
            child: ListView.builder(
              itemCount: recommendations[selectedCategory]!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(recommendations[selectedCategory]![index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
