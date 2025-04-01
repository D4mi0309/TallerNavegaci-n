import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/services/chucknorris_service.dart';
import 'package:hola_mundo/views/base_view.dart';

class JokeListView extends StatefulWidget {
  const JokeListView({super.key});

  @override
  State<JokeListView> createState() => _JokeListViewState();
}

class _JokeListViewState extends State<JokeListView> {
  final ChuckNorrisService _jokeService = ChuckNorrisService();
  late Future<List<String>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = _jokeService.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Chuck Norris Jokes',
      body: FutureBuilder<List<String>>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      context.push('/chucknorris/$category');
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.mood, size: 40, color: Colors.orange),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                category.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
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
