import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/ChuckNorris/chucknorris_detail_view.dart';
import 'package:hola_mundo/views/ChuckNorris/chucknorris_listview.dart';
import 'package:hola_mundo/views/Establecimiento/establecimiento_createView.dart';
import 'package:hola_mundo/views/Establecimiento/establecimiento_editView.dart';
import 'package:hola_mundo/views/Establecimiento/establecimiento_listView.dart';
import 'package:hola_mundo/views/Future/future_view.dart';
import 'package:hola_mundo/views/Isolate/isolate_view.dart';
import 'package:hola_mundo/views/Timer/timer_view.dart';
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
      path: '/future',
      builder: (context, state) => const ListaEstudiantesView(),
    ),
    GoRoute(path: '/timer', builder: (context, state) => const TimerView()),
    GoRoute(path: '/isolate', builder: (context, state) => const IsolateView()),
    GoRoute(
      path: '/detalle',
      builder: (context, state) {
        final parametro = state.uri.queryParameters['parametro'] ?? 'Sin dato';
        return DetalleScreen(parametro: parametro);
      },
    ),
    GoRoute(
      path: '/chucknorris',
      name: 'ChuckNorris',
      builder: (context, state) => const JokeListView(),
    ),
    GoRoute(
      path: '/chucknorris/:category',
      name: 'ChucknorrisDetail',
      builder:
          (context, state) =>
              JokeDetailView(category: state.pathParameters['category']!),
    ),
    GoRoute(
      path: '/establecimientos',
      name: 'establecimientos',
      builder: (context, state) => const EstablecimientosListView(),
    ),

    // Ruta para crear un establecimiento
    GoRoute(
      path: '/establecimiento/create',
      name: 'establecimientoscrear',
      builder: (context, state) => const EstablecimientoCreateView(),
    ),

    // Ruta para editar un establecimiento (recibe un ID)
    GoRoute(
      path: '/establecimientos/edit/:id',
      name: 'establecimientoseditar',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return EstablecimientoEditView(id: id);
      },
    ),
  ],
);
