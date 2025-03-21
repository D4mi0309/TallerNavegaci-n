import 'package:go_router/go_router.dart';
import '../views/home_view.dart';
import '../views/ciclo_vida/ciclo_vida_screen.dart';
import '../views/paso_parametros/detalle_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeView()),
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    GoRoute(
      path: '/detalle',
      builder: (context, state) {
        final parametro = state.uri.queryParameters['parametro'] ?? 'Sin dato';
        return DetalleScreen(parametro: parametro);
      },
    ),
  ],
);
