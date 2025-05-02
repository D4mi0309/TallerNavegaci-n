import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hola_mundo/themes/app_theme.dart';
import 'routes/app_router.dart';
import 'package:hola_mundo/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //! Importante para que funcione el dotenv, inicializa el widget
  await dotenv.load(fileName: ".env");

  //! Ejecuta la app con Provider
  runApp(
    //!multiprovider permite usar varios providers en la app
    //! en este caso solo se usa el ThemeProvider, pero se pueden agregar más
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //* El provider se encarga de gestionar el color del tema de la app
          //* y notificar a los widgets que lo usan cuando cambia
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeColor = themeProvider.color;

    return MaterialApp.router(
      title: 'Flutter Taller',
      theme: AppTheme.lightTheme(themeColor),
      darkTheme: AppTheme.darkTheme(themeColor),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
