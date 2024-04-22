import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/custbox.dart';
import 'package:flutter_application_2/widgets/customwidget.dart'; // Importa el archivo de la alerta

class VerificacionScreen extends StatelessWidget {
  const VerificacionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.how_to_reg_outlined,
      Icons.verified_user_outlined,
      Icons.ballot,
      Icons.calendar_month_outlined,
    ];

    List<String> textos = [
      'Autenticación',
      'Verificación',
      'Elección',
      'Agenda disponible',
    ];

    return Scaffold(
      body: Column(
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
              'Nuestro mensaje de verificación está diseñado para asegurar la\nprotección de tus datos. Queremos garantizar la seguridad de tu\ninformación, proporcionándote un proceso confiable que\nproteja tus datos personales.',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 9,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              icons.length,
              (index) => CusWidget(
                icon: icons[index],
                text: textos[index],
                circleColor: index == 1
                    ? const Color(0xFF112F6A)
                    : const Color(0xFFB0E1F4),
                textColor: index == 1
                    ? const Color(0xFF112F6A)
                    : const Color(0xFFB0E1F4),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Ingresa el código de seguridad que te enviamos',
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 11,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Ingresa el código',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
          CustomButtons(
            onBackPressed: () {
              Navigator.pushNamed(context, 'autenticacion');
            },
            onNextPressed: () {
              Navigator.pushNamed(context, 'eleccion');
            },
          ),
        ],
      ),
    );
  }
}
