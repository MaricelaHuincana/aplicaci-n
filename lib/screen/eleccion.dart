import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/custbox.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';
import 'package:flutter_application_2/widgets/alertacancelado.dart'; // Importa la alerta de cancelado

class EleccionScreen extends StatefulWidget {
  const EleccionScreen({Key? key}) : super(key: key);

  @override
  _EleccionScreenState createState() => _EleccionScreenState();
}

class _EleccionScreenState extends State<EleccionScreen> {
  int? _selectedOption;

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
                fontWeight: FontWeight.w400,
              ),
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
                circleColor: index == 2
                    ? const Color(0xFF112F6A)
                    : const Color(0xFFB0E1F4),
                textColor: index == 2
                    ? const Color(0xFF112F6A)
                    : const Color(0xFFB0E1F4),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '¿Prefieres cancelar tu hora médica actual o reagendar para\notra fecha?',
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 10,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = 1;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _selectedOption,
                          onChanged: (value) {},
                        ),
                        const Text(
                          'Reagendar hora medica',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 11,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = 0;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Radio(
                          value: 0,
                          groupValue: _selectedOption,
                          onChanged: (value) {},
                        ),
                        const Text(
                          'Cancelar hora medica',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 11,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomButtons(
            onBackPressed: () {
              Navigator.pushNamed(context, 'verificacion');
            },
            onNextPressed: () {
              if (_selectedOption == 0) {
                AlertaCancelado.mostrar(
                    context, 'Has cancelado tu hora médica.');
              } else {
                Navigator.pushNamed(context, 'zona');
              }
            },
          ),
        ],
      ),
    );
  }
}