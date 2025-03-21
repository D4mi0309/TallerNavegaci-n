import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetalleScreen extends StatelessWidget {
  final String parametro;

  const DetalleScreen({super.key, required this.parametro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parametros'),
        backgroundColor: Color.fromRGBO(255, 162, 0, 1),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text(
                'Menú de navegación',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                context.go('/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.autorenew),
              title: const Text('Ciclo de Vida'),
              onTap: () {
                Navigator.pop(context);
                context.go('/ciclo_vida');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Parámetro recibido: $parametro',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
