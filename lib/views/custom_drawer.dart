import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            leading: const Icon(Icons.timer),
            title: const Text('Timer'),
            onTap: () {
              GoRouter.of(context).go('/timer');
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: const Text('Future'),
            onTap: () {
              GoRouter.of(context).go('/future');
            },
          ),
          ListTile(
            leading: const Icon(Icons.scale_outlined),
            title: const Text('Isolate'),
            onTap: () {
              GoRouter.of(context).go('/isolate');
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
}
