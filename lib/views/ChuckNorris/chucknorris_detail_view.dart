import 'package:flutter/material.dart';
import 'package:hola_mundo/models/chucknorris.dart';
import 'package:hola_mundo/services/chucknorris_service.dart';

class JokeDetailView extends StatefulWidget {
  final String category;

  const JokeDetailView({super.key, required this.category});

  @override
  State<JokeDetailView> createState() => _JokeDetailViewState();
}

class _JokeDetailViewState extends State<JokeDetailView> {
  final ChuckNorrisService _jokeService = ChuckNorrisService();
  late Future<ChuckNorrisJoke> _futureJoke;

  @override
  void initState() {
    super.initState();
    _futureJoke = _jokeService
        .getJokesByCategory(widget.category)
        .then((list) => list.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Joke: ${widget.category.toUpperCase()}')),
      body: FutureBuilder<ChuckNorrisJoke>(
        future: _futureJoke,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final joke = snapshot.data!;
            return Center(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sentiment_very_satisfied,
                        size: 80,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        joke.joke,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Chip(
                        label: Text(joke.category.toUpperCase()),
                        backgroundColor: Colors.blueGrey.shade100,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
