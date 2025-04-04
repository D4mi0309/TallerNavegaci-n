import 'package:flutter/material.dart';
import 'package:hola_mundo/models/establecimiento.dart';
import 'package:hola_mundo/services/establecimiento_service.dart';
import 'package:hola_mundo/views/base_view.dart';
import 'package:go_router/go_router.dart';

class EstablecimientosListView extends StatefulWidget {
  const EstablecimientosListView({super.key});

  @override
  EstablecimientosListViewState createState() =>
      EstablecimientosListViewState();
}

class EstablecimientosListViewState extends State<EstablecimientosListView> {
  final EstablecimientoService _service = EstablecimientoService();
  late Future<List<Establecimiento>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getEstablecimientos();
  }

  Future<void> _goToEdit(int id) async {
    final result = await context.push('/establecimientos/edit/$id');

    if (result == true) {
      setState(() {
        _future = _service.getEstablecimientos();
      });
    }
  }

  //! Método para eliminar un establecimiento
  Future<void> _deleteEstablecimiento(int id) async {
    bool eliminado = await _service.deleteEstablecimiento(id);
    if (eliminado) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Establecimiento eliminado correctamente')),
      );
      setState(() {
        _future = _service.getEstablecimientos(); // Recarga la lista
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar el establecimiento')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BaseView(
          title: 'Establecimientos',
          body: FutureBuilder<List<Establecimiento>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No hay establecimientos disponibles'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final establecimiento = snapshot.data![index];
                  return GestureDetector(
                    onTap: () => _goToEdit(establecimiento.id),
                    child: Card(
                      margin: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child:
                                  (establecimiento.logo ?? '').isNotEmpty
                                      ? Image.network(
                                        '${_service.baseUrlImg}${establecimiento.logo}',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      )
                                      : Icon(Icons.camera_indoor, size: 80),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    establecimiento.nombre,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('NIT: ${establecimiento.nit}'),
                                  Text(
                                    'Dirección: ${establecimiento.direccion}',
                                  ),
                                  Text('Teléfono: ${establecimiento.telefono}'),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed:
                                  () => _deleteEstablecimiento(
                                    establecimiento.id,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => context.push('/establecimiento/create'),
            backgroundColor: Colors.orange,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
