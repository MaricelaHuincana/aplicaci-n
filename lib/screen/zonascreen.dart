import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/custombuttons.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class ZonaScreen extends StatefulWidget {
  ZonaScreen({Key? key}) : super(key: key);

  @override
  _ZonaScreenState createState() => _ZonaScreenState();
}

class _ZonaScreenState extends State<ZonaScreen> {
  String? selectedLocation;
  bool checkBoxValue = false;

  Future<void> enviarDatosAlServidor(String idSucursal, String nombre,
      String direccion, String telefono, int idProfesional) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://localhost:1337/api/sucuesals'));
    request.body = json.encode({
      "data": {
        "id_sucursal": idSucursal,
        "nombre_sucursal": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "id_profecional": idProfesional
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/1.png',
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
            'Selecciona una sucursal de preferencia',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF000000),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          _buildLocationRadioButton('Granollers'),
          _buildLocationRadioButton('Barcelona (Gracia)'),
          _buildLocationRadioButton('Barcelona (Ciutat Vella)'),
          _buildLocationRadioButton('Sabedell'),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 15),
              Checkbox(
                activeColor: const Color(0xFF066699),
                value: checkBoxValue,
                onChanged: (value) {
                  setState(() {
                    checkBoxValue = value!;
                  });
                },
              ),
              const Text(
                'Al continuar usted acepta y confirma haber\n entendido nuestra política de privacidad.',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          CustomNavigationButtons(
            onBackPressed: () {
              Navigator.pushNamed(context, 'home');
            },
            onNextPressed: () async {
              if (selectedLocation != null && checkBoxValue) {
                if (selectedLocation == 'Granollers') {
                  await enviarDatosAlServidor(
                      "1", "Granollers", "rivas 775", "921815398", 1);
                } else if (selectedLocation == 'Barcelona (Ciutat Vella)') {
                  await enviarDatosAlServidor("2", "Barcelona (Ciutat Vella)",
                      "ulkatrun 775", "921815399", 1);
                } else if (selectedLocation == 'Barcelona (Gracia)') {
                  await enviarDatosAlServidor(
                      "3", "Barcelona (Gracia)", "neruda 775", "966266468", 1);
                } else if (selectedLocation == 'Sabedell') {
                  await enviarDatosAlServidor(
                      "4", "Sabedell", "rivera 775", "921815349", 1);
                }

                Navigator.pushNamed(
                  context,
                  'especialidad',
                  arguments: {
                    'zonaSeleccionada': selectedLocation!,
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRadioButton(String location) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF066699), width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Radio(
            activeColor: const Color(0xFF066699),
            value: location,
            groupValue: selectedLocation,
            onChanged: (value) {
              setState(() {
                selectedLocation = value as String?;
              });
            },
          ),
          const SizedBox(width: 20),
          Text(
            location,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
