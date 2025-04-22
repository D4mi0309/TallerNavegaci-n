import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Perfil', // Título de la pantalla
      body: const Center(child: Text('Pantalla de perfil')),
    );
  }
}
