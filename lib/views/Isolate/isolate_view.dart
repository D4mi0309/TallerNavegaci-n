import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class IsolateView extends StatefulWidget {
  const IsolateView({super.key});

  @override
  State<IsolateView> createState() => _IsolateViewState();
}

class _IsolateViewState extends State<IsolateView> {
  String resultado = "Presiona el botón para ejecutar";

  //! Función que ejecuta la tarea pesada en un Isolate
  Future<void> ejecutarTareaPesada() async {
    final receivePort = ReceivePort();

    // Inicia el Isolate
    await Isolate.spawn(_tareaPesada, receivePort.sendPort);

    // Obtiene el SendPort del nuevo Isolate
    final sendPort = await receivePort.first as SendPort;

    // Canal para recibir la respuesta
    final response = ReceivePort();

    // Envía la solicitud al Isolate
    sendPort.send(response.sendPort);

    // Espera la respuesta del Isolate
    final suma = await response.first as int;

    if (!mounted) return; // Valida si el widget sigue montado

    setState(() {
      resultado = "Suma del 1 al 2,000,000: $suma";
    });

    // Muestra un SnackBar con el resultado
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(resultado)));
  }

  //! Tarea pesada en el Isolate
  static void _tareaPesada(SendPort sendPort) {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    port.listen((message) {
      int suma = 0;
      for (int i = 1; i <= 2000000; i++) {
        suma += i;
      }

      final SendPort replyPort = message as SendPort;
      replyPort.send(suma);

      port.close();
      Isolate.exit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "Tarea Pesada con Isolate",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(resultado, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ejecutarTareaPesada,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 168, 76, 1),
                  disabledBackgroundColor: Color.fromRGBO(209, 137, 60, 1),
                  foregroundColor: Colors.black,
                ),
                child: const Text("Ejecutar tarea en segundo plano"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
