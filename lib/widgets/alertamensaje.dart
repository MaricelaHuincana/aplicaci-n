import 'package:flutter/material.dart';

class AlertaNumero {
  static void mostrar(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'verificacion');
          },
          child: AlertDialog(
            title: const Text(
              'Te hemos enviado\n      un mensaje',
              style: TextStyle(
                  color: Color(0xFFAD4409),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/email.png',
                  width: 220,
                  height: 230,
                ),
                const Text(
                    ' Enviamos un mensaje de texto\n   al número +34 XXXXXX28.',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 14)),
                const SizedBox(height: 10),
                const Text('Te invitamos a revisar!',
                    style: TextStyle(
                        color: Color(0xFFAD4409),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 18)),
              ],
            ),
          ),
        );
      },
    );
  }
}
