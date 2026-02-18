import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MovieApp());

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineStream Ultra',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF050505), // Deeper Black
        colorSchemeSeed: Colors.redAccent,
      ),
      home: const MovieHomeScreen(),
    );
  }
}

// --- DATA MODEL ---
class Show {
  final int id;
  final String name;
  final String image;
  final double rating;
  final String genre;

  Show({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.genre,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      // CHANGED: Pulling 'original' instead of 'medium' for high quality
      image: (json['image'] != null)
          ? json['image']['original']
          : 'https://via.placeholder.com/600x800?text=No+Image',
      rating: (json['rating'] != null && json['rating']['average'] != null)
          ? (json['rating']['average'] as num).toDouble()
          : 0.0,
      genre: (json['genres'] != null && (json['genres'] as List).isNotEmpty)
          ? json['genres'][0]
          : 'Drama',
    );
  }
}

class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({super.key});

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  List<Show> allShows = [];
  List<Show> filteredShows = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchShows();
  }

  Future<void> fetchShows() async {
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/shows'));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        setState(() {
          allShows = body.map((item) => Show.fromJson(item)).toList();
          filteredShows = allShows;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredShows = allShows
          .where((show) => show.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            const Text('CINESTREAM',
                style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 5, color: Colors.redAccent, fontSize: 28)),
            const SizedBox(height: 20),
            TextField(
              onChanged: filterSearchResults,
              decoration: InputDecoration(
                hintText: "Search high-res titles...",
                prefixIcon: const Icon(Icons.search, color: Colors.redAccent),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.redAccent))
          : GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.65,
        ),
        itemCount: filteredShows.length,
        itemBuilder: (context, index) {
          final show = filteredShows[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.redAccent.withOpacity(0.1), blurRadius: 15, spreadRadius: 2)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // HIGH QUALITY IMAGE LOADING
                  Positioned.fill(
                    child: Image.network(
                      show.image,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high, // Set to High for Desktop
                    ),
                  ),
                  // GRADIENT OVERLAY
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  // TEXT CONTENT
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(show.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17), maxLines: 1),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 5),
                            Text(show.rating.toString(), style: const TextStyle(fontSize: 13)),
                            const Spacer(),
                            Text(show.genre, style: const TextStyle(color: Colors.redAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
