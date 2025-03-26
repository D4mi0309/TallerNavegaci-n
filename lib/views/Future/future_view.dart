import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class ListaEstudiantesView extends StatefulWidget {
  const ListaEstudiantesView({super.key});

  @override
  State<ListaEstudiantesView> createState() => _ListaEstudiantesViewState();
}

class _ListaEstudiantesViewState extends State<ListaEstudiantesView> {
  late Future<List<String>> _futureNombres;

  @override
  void initState() {
    super.initState();
    _futureNombres = cargarNombres();
  }

  Future<List<String>> cargarNombres() async {
    await Future.delayed(const Duration(seconds: 5));
    return [
      'Juan',
      'Pedro',
      'Luis',
      'Ana',
      'Maria',
      'Jose',
      'Carlos',
      'Sofia',
      'Laura',
      'Fernando',
      'Ricardo',
      'Diana',
      'Elena',
      'Miguel',
      'Rosa',
      'Luz',
      'Carmen',
      'Pablo',
      'Jorge',
      'Roberto',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Lista de Estudiantes',
      body: FutureBuilder<List<String>>(
        future: _futureNombres,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay estudiantes disponibles'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.orangeAccent[200],
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(
                      snapshot.data![index],
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
