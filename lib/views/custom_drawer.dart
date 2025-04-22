import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/services/auth_services.dart';
import 'package:hola_mundo/models/user.dart';

class CustomDrawer extends StatelessWidget {
  final User? user; // Se recibe el usuario como parámetro

  const CustomDrawer({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.orangeAccent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? 'Usuario desconocido',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              GoRouter.of(context).go('/');
            },
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
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('ChuckNorris'),
            onTap: () {
              GoRouter.of(context).go('/chucknorris');
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_siding),
            title: const Text('establecimientos'),
            onTap: () {
              GoRouter.of(context).go('/establecimientos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Iniciar sesión'),
            onTap: () {
              context.goNamed('login');
              Navigator.pop(context); // Cierra el Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () async {
              final token = await AuthService().getToken();

              if (token != null) {
                await AuthService().logout();

                if (!context.mounted) {
                  return;
                }
                context.go('/login');
              } else {
                if (!context.mounted) return;
                Navigator.pop(context); // Cierra el drawer
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No hay sesión activa.')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
