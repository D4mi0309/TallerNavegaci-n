import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Principal'),
        backgroundColor: Color.fromRGBO(255, 162, 0, 1),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'GridView'), Tab(text: 'Table')],
        ),
      ),
      drawer: _buildMenu(context), // Menú lateral agregado
      body: TabBarView(
        controller: _tabController,
        children: [_buildGridView(), _buildOtroWidget()],
      ),
    );
  }

  /// Construye el menú lateral con opciones de navegación.
  Widget _buildMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: Text(
              'Menú de Navegación',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.autorenew),
            title: const Text('Ciclo de Vida'),
            onTap: () {
              GoRouter.of(context).go('/ciclo_vida');
            },
          ),
          ListTile(
            leading: const Icon(Icons.route),
            title: const Text('GoRouter'),
            onTap: () {
              GoRouter.of(context).go('/detalle');
            },
          ),
        ],
      ),
    );
  }

  /// Construye el GridView con elementos numerados.
  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Celda $index',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        );
      },
    );
  }

  /// Construye un widget de ejemplo en la segunda pestaña.
  Widget _buildOtroWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('APELLIDO'),
                  ),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('NOMBRE')),
                ],
              ),
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(8.0), child: Text('Gil')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('Damian')),
                ],
              ),
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(8.0), child: Text('Paez')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('Luis')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
