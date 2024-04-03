import 'package:flutter/material.dart';

class AlertaCancelado {
  static void mostrar(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          child: AlertDialog(
            title: const Text(
              'Se a cancelado tu\n      cita medica',
              style: TextStyle(
                  color: Color(0xFF2347A9),
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/doctors.png',
                  width: 220,
                  height: 230,
                ),
                const Text(
                    'Estamos aquí para brindar asistencia en caso de que desee reprogramarla más\n                          adelante.',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 11)),
                const SizedBox(height: 10),
                const Text('¡Gracias!',
                    style: TextStyle(
                        color: Color(0xFFAD4409),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }
}
