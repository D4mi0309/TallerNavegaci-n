import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  Timer? _timer;
  int _contador = 0;
  bool _estaPausado = false;

  //iniciar o reanudar el temporizador
  void _iniciarTemporizador() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _contador++;
        });
      });
      setState(() {
        _estaPausado = false;
      });
    }
  }

  //pausar el temporizador
  void _pausarTemporizador() {
    _timer?.cancel();
    setState(() {
      _estaPausado = true;
    });
  }

  //reiniciar el temporizador
  void _reiniciarTemporizador() {
    _timer?.cancel();
    setState(() {
      _contador = 0;
      _estaPausado = false;
    });
    _iniciarTemporizador();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador al cerrar la pantalla
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Temporizador',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Segundos: $_contador', style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _estaPausado ? _iniciarTemporizador : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 168, 76, 1),
                  disabledBackgroundColor: Color.fromRGBO(209, 137, 60, 1),
                  foregroundColor: Colors.black,
                ),
                child: const Text('Iniciar/Reanudar'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _estaPausado ? null : _pausarTemporizador,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 168, 76, 1),
                  disabledBackgroundColor: Color.fromRGBO(209, 137, 60, 1),
                  foregroundColor: Colors.black,
                ),
                child: const Text('Pausar'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _reiniciarTemporizador,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 168, 76, 1),
                  disabledBackgroundColor: Color.fromRGBO(209, 137, 60, 1),
                  foregroundColor: Colors.black,
                ),
                child: const Text('Reiniciar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
