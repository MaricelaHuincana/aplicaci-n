import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/custombuttons.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfesionalScreen extends StatefulWidget {
  const ProfesionalScreen({Key? key}) : super(key: key);

  @override
  _ProfesionalScreenState createState() => _ProfesionalScreenState();
}

class _ProfesionalScreenState extends State<ProfesionalScreen> {
  String selectedProfesional =
      ''; // Variable para manejar el profesional seleccionado

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.check_circle_outline_outlined,
      FontAwesomeIcons.stethoscope,
      FontAwesomeIcons.briefcaseMedical,
      Icons.calendar_month_outlined,
      Icons.schedule,
      Icons.person_outline_outlined,
      Icons.check_circle_outline_outlined,
    ];

    List<String> textos = [
      'Zona',
      'Especialidad',
      'Profesional',
      'Agenda disponible',
      'Hora',
      'Datos personales',
      'Confirmación',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/5.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: 150,
            ),
            const WelcomeTextWidget(
              welcomeText: 'Bienvenido',
              reservationText: 'Reserva aquí tu hora médica',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                icons.length,
                (index) => CustomWidget(
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
            const SizedBox(height: 15),
            const Text(
              'Selecciona un profesional para la atención',
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            _buildProfesionalCard(1),
            _buildProfesionalCard(2),
            _buildProfesionalCard(3),
            const SizedBox(height: 10),
            CustomNavigationButtons(
              onBackPressed: () {
                Navigator.pushNamed(context, 'especialidad');
              },
              onNextPressed: () async {
                if (selectedProfesional.isNotEmpty) {
                 
                  await _sendProfesionalDataToAPI(selectedProfesional);
                  Navigator.pushNamed(context, 'agendadisponible');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Selecciona un profesional antes de continuar'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfesionalCard(int cardIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFB0E1F4), width: 1),
        borderRadius: BorderRadius.circular(0.2),
      ),
      child: Row(
        children: [
          _buildProfesionalImage(),
          const SizedBox(width: 15),
          _buildProfesionalInfo(),
          const SizedBox(width: 10),
          _buildRadioButtons(cardIndex),
        ],
      ),
    );
  }

  Widget _buildProfesionalImage() {
    return const CircleAvatar(
      radius: 12,
      backgroundImage: AssetImage('assets/doct.png'),
    );
  }

  Widget _buildProfesionalInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Doctora Mariela Garay A.',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            'Gastroenteróloga',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 0.5),
          Row(
            children: [
              _buildLogo(),
              _buildLogo1(),
              _buildLogo2(),
              _buildLogo2(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: const CircleAvatar(
        radius: 12,
        backgroundImage: AssetImage('assets/Ellipse 6.png'),
      ),
    );
  }

  Widget _buildLogo1() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: const CircleAvatar(
        radius: 12,
        backgroundImage: AssetImage('assets/convenio.png'),
      ),
    );
  }

  Widget _buildLogo2() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: const CircleAvatar(
        radius: 12,
        backgroundImage: AssetImage('assets/conv.png'),
      ),
    );
  }

  Widget _buildRadioButtons(int cardIndex) {
    return Radio(
      value: 'Profesional $cardIndex',
      groupValue: selectedProfesional,
      onChanged: (value) {
        setState(() {
          selectedProfesional = value as String;
        });
      },
    );
  }

  Future<void> _sendProfesionalDataToAPI(String selectedProfesional) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://localhost:1337/api/profecionals'));
    request.body = json.encode({
      "data": {
        "id_profecional": "1",
        "nombre": "Doctora Mariela",
        "apellido": "Garayy",
        "especialidad_profecional": selectedProfesional,
        "beneficio_atencion": "fonasa",
        "id_agenda": 1,
        "id_especialidad": 5,
        "id_sucursal": 1
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
