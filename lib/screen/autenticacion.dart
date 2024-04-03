import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/CustomBox.dart';
import 'package:flutter_application_2/widgets/alertamensaje.dart';
import 'package:flutter_application_2/widgets/custbox.dart';

import 'package:flutter_application_2/widgets/customwidget.dart';

class AutenticacionScreen extends StatelessWidget {
  const AutenticacionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.check_circle_outline_outlined,
      Icons.favorite,
      Icons.music_note,
      Icons.directions_walk,
    ];

    List<String> textos = [
      'Autenticación',
      'Verificación',
      'Elección',
      'Agenda disponible',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/8.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: 150,
            ),
            const WelcomeTextWidget(
              welcomeText: 'Bienvenido',
              reservationText: '¡Te damos la libertad de elegir!',
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Si necesitas cambiar tu cita médica, ya sea cancelándola o reagendándola, estamos aquí para ayudarte.',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 10,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                icons.length,
                (index) => CusWidget(
                  icon: icons[index],
                  text: textos[index],
                  circleColor: index == 0
                      ? const Color(0xFF112F6A)
                      : const Color(0xFFB0E1F4),
                  textColor: index == 0
                      ? const Color(0xFF112F6A)
                      : const Color(0xFFB0E1F4),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Ingresa la información solicitada para gestionar la cancelación o reprogramación de tu cita médica.',
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 10,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const CustoBox(
              labelText: 'Identificación alfanumérica',
              hintText: 'Ingresa tu identificación alfanumérica',
            ),
            const SizedBox(height: 10),
            const CustoBox(
              labelText: 'Número telefónico',
              hintText: 'Ingresa tu Número telefónico',
            ),
            const SizedBox(height: 10),
            const CustoBox(
              labelText: 'Correo electrónico',
              hintText: 'Ingresa tu Correo electrónico',
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 15),
                Checkbox(
                  value: false, // Puedes manejar el estado del checkbox
                  onChanged: (value) {
                    // Implementa la lógica cuando cambia el estado del checkbox
                  },
                ),
                const Text(
                  'Al continuar usted acepta y confirma haber entendido\nnuestra política de privacidad.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 11,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomButtons(
              onBackPressed: () {
                Navigator.pushNamed(context, 'home');
              },
              onNextPressed: () {
                // Mostrar la alerta de mensaje
                AlertaNumero.mostrar(
                    context, 'Este es un mensaje de verificación');
              },
            ),
          ],
        ),
      ),
    );
  }
}
