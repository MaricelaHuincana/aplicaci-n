import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/custombuttons.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class HoraScreen extends StatefulWidget {
  final DateTime selectedDay;

  const HoraScreen({Key? key, required this.selectedDay}) : super(key: key);

  @override
  _HoraScreenState createState() => _HoraScreenState();
}

class _HoraScreenState extends State<HoraScreen> {
  late String selectedHour;

  @override
  void initState() {
    super.initState();
    selectedHour = '';
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
            'assets/6.png',
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
                circleColor: index == 4
                    ? const Color(0xFF112F6A)
                    : const Color(0xFFB0E1F4),
                textColor: index == 4
                    ? const Color(0xFF112F6A)
                    : const Color(0xFFB0E1F4),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Selecciona la hora en que deseas la atención',
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          _buildHoraContainer('8:00 am '),
          _buildHoraContainer('8:30 am '),
          _buildHoraContainer('9:20 am '),
          _buildHoraContainer('10:10 am'),
          const SizedBox(height: 24),
          CustomNavigationButtons(
            onBackPressed: () {
              Navigator.pushNamed(context, 'agendadisponible');
            },
            onNextPressed: () {
              if (selectedHour.isNotEmpty) {
                _saveDateAndHourToStrapi(widget.selectedDay, selectedHour);
                Navigator.pushNamed(
                  context,
                  'datospersonales',
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Selecciona una hora antes de continuar'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHoraContainer(String hora) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedHour = hora;
        });
      },
      child: Container(
        height: 46,
        width: 300,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFB0E1F4), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.access_time,
                color: Color(0xFFD9D9D9),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              hora,
              style: const TextStyle(
                color: Color(0xFF000000),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 150),
            Radio(
              value: hora,
              groupValue: selectedHour,
              onChanged: (value) {
                setState(() {
                  selectedHour = value as String;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveDateAndHourToStrapi(
      DateTime selectedDay, String selectedHour) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://localhost:1337/api/agenda-medicas'));
    request.body = json.encode({
      "data": {
        "id_agenda": "1",
        "hora": selectedHour,
        "fecha": selectedDay.toString(),
        "id_profecional": 3,
        "id_alfanumerica": 1
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
