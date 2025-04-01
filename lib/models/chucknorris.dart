// Modelo para representar un chiste de Chuck Norris
class ChuckNorrisJoke {
  final String id;
  final String joke;
  final String category;

  // Constructor de la clase
  ChuckNorrisJoke({
    required this.id,
    required this.joke,
    required this.category,
  });

  // Método para convertir JSON en una instancia de ChuckNorrisJoke
  factory ChuckNorrisJoke.fromJson(Map<String, dynamic> json) {
    return ChuckNorrisJoke(
      id: json['id'],
      joke: json['value'],
      category:
          (json['categories'] as List).isNotEmpty
              ? json['categories'][0]
              : 'Uncategorized',
    );
  }
}
