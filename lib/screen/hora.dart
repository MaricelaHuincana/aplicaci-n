import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/custombuttons.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';

class HoraScreen extends StatefulWidget {
  const HoraScreen({Key? key}) : super(key: key);

  @override
  _HoraScreenState createState() => _HoraScreenState();
}

class _HoraScreenState extends State<HoraScreen> {
  late String selectedHour; // Variable para la hora seleccionada

  @override
  void initState() {
    super.initState();
    selectedHour = ''; // Inicializar la hora seleccionada como vacía
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
              // Verificar si se ha seleccionado una hora antes de continuar
              if (selectedHour.isNotEmpty) {
                Navigator.pushNamed(context, 'datospersonales');
              } else {
                // Mostrar mensaje indicando que se debe seleccionar una hora
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
              child: Icon(Icons.access_time),
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
                // Actualizar la hora seleccionada
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
}
