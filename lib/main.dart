// lib/main.dart

import 'package:flutter/material.dart';
import 'dart:collection';

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
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        cardColor: Colors.white,
        scaffoldBackgroundColor: Colors.indigo[50],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
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
  final List<String> categories = ['Movies', 'Books', 'Music', 'Games', 'Restaurants'];
  String selectedCategory = 'Movies';

  final Map<String, List<Map<String, String>>> recommendations = {
    'Movies': [
      {
        'title': 'Inception',
        'desc': '夢の中で夢を操るSF映画。',
        'img': 'assets/images/movie.jpg',
      },
      {
        'title': 'Interstellar',
        'desc': '宇宙と親子愛の壮大な物語。',
        'img': 'assets/images/movie.jpg',
      },
      {
        'title': 'The Matrix',
        'desc': '仮想現実と哲学が交錯する名作。',
        'img': 'assets/images/movie.jpg',
      },
    ],
    'Books': [
      {
        'title': '1984',
        'desc': 'ディストピア社会を描いた不朽の名作。',
        'img': 'assets/images/book.jpg',
      },
      {
        'title': 'Brave New World',
        'desc': '管理社会の未来を予見した一冊。',
        'img': 'assets/images/book.jpg',
      },
      {
        'title': 'Fahrenheit 451',
        'desc': '本が禁じられた世界での闘い。',
        'img': 'assets/images/book.jpg',
      },
    ],
    'Music': [
      {
        'title': 'Bohemian Rhapsody',
        'desc': 'Queenの名曲。壮大な展開。',
        'img': 'assets/images/music.jpg',
      },
      {
        'title': 'Stairway to Heaven',
        'desc': 'Led Zeppelinの伝説的バラード。',
        'img': 'assets/images/music.jpg',
      },
      {
        'title': 'Hotel California',
        'desc': 'Eaglesの不朽の名曲。',
        'img': 'assets/images/music.jpg',
      },
    ],
    'Games': [
      {
        'title': 'ゼルダの伝説',
        'desc': '冒険と謎解きの王道アクション。',
        'img': 'assets/images/movie.jpg',
      },
      {
        'title': 'Minecraft',
        'desc': '自由度MAXのサンドボックスゲーム。',
        'img': 'assets/images/movie.jpg',
      },
      {
        'title': 'Among Us',
        'desc': 'みんなで疑心暗鬼パーティー。',
        'img': 'assets/images/movie.jpg',
      },
    ],
    'Restaurants': [
      {
        'title': '寿司一番',
        'desc': '新鮮なネタが自慢の寿司屋。',
        'img': 'assets/images/book.jpg',
      },
      {
        'title': 'カレーの王様',
        'desc': 'スパイス香る絶品カレー。',
        'img': 'assets/images/book.jpg',
      },
      {
        'title': 'ラーメン太郎',
        'desc': 'こだわりスープのラーメン店。',
        'img': 'assets/images/book.jpg',
      },
    ],
  };

  final Map<String, IconData> categoryIcons = {
    'Movies': Icons.movie,
    'Books': Icons.book,
    'Music': Icons.music_note,
    'Games': Icons.sports_esports,
    'Restaurants': Icons.restaurant,
  };

  final Set<String> favorites = HashSet();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        cardColor: Colors.white,
        scaffoldBackgroundColor: Colors.indigo[50],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            children: [
              Icon(categoryIcons[selectedCategory], color: Colors.white),
              const SizedBox(width: 12),
              const Text('Recommendations for You'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () {
                // ダークモード切替はシステム依存
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...categories.map((category) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Row(
                          children: [
                            Icon(categoryIcons[category], size: 20),
                            const SizedBox(width: 4),
                            Text(category),
                          ],
                        ),
                        selected: selectedCategory == category,
                        selectedColor: Colors.indigo,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: ListView.builder(
                  key: ValueKey(selectedCategory),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: recommendations[selectedCategory]!.length,
                  itemBuilder: (context, index) {
                    final item = recommendations[selectedCategory]![index];
                    final favKey = '${selectedCategory}_${item['title']}';
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item['img'] ?? '',
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[300],
                              width: 48,
                              height: 48,
                              child: Icon(categoryIcons[selectedCategory], color: Colors.white),
                            ),
                          ),
                        ),
                        title: Text(item['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(item['desc'] ?? ''),
                        trailing: IconButton(
                          icon: Icon(
                            favorites.contains(favKey) ? Icons.favorite : Icons.favorite_border,
                            color: favorites.contains(favKey) ? Colors.pink : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if (favorites.contains(favKey)) {
                                favorites.remove(favKey);
                              } else {
                                favorites.add(favKey);
                              }
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (favorites.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.indigo[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('お気に入り', style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: favorites.map((fav) {
                        final parts = fav.split('_');
                        return Chip(
                          label: Text(parts.length > 1 ? parts[1] : fav),
                          avatar: Icon(categoryIcons[parts[0]] ?? Icons.star),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
