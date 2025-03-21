import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CicloVidaScreen extends StatefulWidget {
  const CicloVidaScreen({super.key});

  @override
  _CicloVidaScreenState createState() => _CicloVidaScreenState();
}

class _CicloVidaScreenState extends State<CicloVidaScreen> {
  @override
  void initState() {
    super.initState();
    print('initState: La pantalla se ha inicializado');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies: Dependencias cambiadas');
  }

  @override
  Widget build(BuildContext context) {
    print('build: Construyendo la interfaz');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo de Vida'),
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
              leading: const Icon(Icons.route),
              title: const Text('Paso de Parámetros'),
              onTap: () {
                Navigator.pop(context);
                context.go('/detalle?parametro=Ejemplo');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              print('setState: Estado actualizado');
            });
          },
          child: const Text('Actualizar Estado'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('dispose: La pantalla se ha destruido');
    super.dispose();
  }
}
