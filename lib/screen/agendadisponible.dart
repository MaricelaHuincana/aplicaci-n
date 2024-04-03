import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_2/widgets/custombuttons.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaDisponibleScreen extends StatefulWidget {
  const AgendaDisponibleScreen({Key? key}) : super(key: key);

  @override
  _AgendaDisponibleScreenState createState() => _AgendaDisponibleScreenState();
}

class _AgendaDisponibleScreenState extends State<AgendaDisponibleScreen> {
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.check_circle_outline_outlined,
      Icons.favorite,
      Icons.music_note,
      Icons.directions_walk,
      Icons.local_pizza,
      Icons.phone,
      Icons.school,
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

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/7.png',
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
                  circleColor: index == 3
                      ? const Color(0xFF112F6A)
                      : const Color(0xFFB0E1F4),
                  textColor: index == 3
                      ? const Color(0xFF112F6A)
                      : const Color(0xFFB0E1F4),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Selecciona la fecha que deseas la atención',
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            _buildCalendario(),
            const SizedBox(height: 35),
            CustomNavigationButtons(
              onBackPressed: () {
                Navigator.pushNamed(context, 'profecional');
              },
              onNextPressed: () {
                Navigator.pushNamed(context, 'hora');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendario() {
    return Container(
      height: 220,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFB0E1F4), // Borde de color rojo
          width: 1,
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: SingleChildScrollView(
        child: TableCalendar(
          locale: 'es_ES',
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: DateTime.now(),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
          },
        ),
      ),
    );
  }
}
