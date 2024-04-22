import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_2/widgets/custbox.dart';

import 'package:flutter_application_2/widgets/customwidget.dart';

class ConfirmacionScreen extends StatelessWidget {
  const ConfirmacionScreen({Key? key}) : super(key: key);

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
    final ConfirmacionArguments args =
        ModalRoute.of(context)!.settings.arguments as ConfirmacionArguments;

    String formattedDate = args.fechaNacimiento != null
        ? DateFormat('dd-MM-yyyy').format(args.fechaNacimiento!)
        : '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  circleColor: index == 6
                      ? const Color(0xFF112F6A)
                      : const Color(0xFFB0E1F4),
                  textColor: index == 6
                      ? const Color(0xFF112F6A)
                      : const Color(0xFFB0E1F4),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Confirmación de la hora médica',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                SizedBox(width: 5),
                Icon(Icons.person, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Información del paciente',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('DNI: ${args.identificacion}'),
                  const SizedBox(height: 5),
                  Text('Nombres: ${args.nombres}'),
                  const SizedBox(height: 5),
                  Text('Apellidos: ${args.apellidos}'),
                  const SizedBox(height: 5),
                  Text(
                    'Fecha de Nacimiento: $formattedDate',
                  ),
                  const SizedBox(height: 5),
                  Text('Dirección: ${args.direccion}'),
                  const SizedBox(height: 5),
                  Text('Comuna: ${args.comuna}'),
                  const SizedBox(height: 5),
                  Text('Teléfono: ${args.telefono}'),
                  const SizedBox(height: 5),
                  Text('Correo Electrónico: ${args.correo}'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                SizedBox(width: 5),
                Icon(Icons.person, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Información de la atención',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5),
                  Text('Zona Seleccionada: ${args.zonaSeleccionada}'),
                  
                ],
              ),
            ),
            const SizedBox(height: 10),
            CustomButtons(
              onBackPressed: () {
                Navigator.pushNamed(context, 'datospersonales');
              },
              onNextPressed: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmacionArguments {
  final String identificacion;
  final String nombres;
  final String apellidos;
  final DateTime? fechaNacimiento;
  final String direccion;
  final String comuna;
  final String telefono;
  final String correo;
  final String zonaSeleccionada;
  

  ConfirmacionArguments({
    required this.identificacion,
    required this.nombres,
    required this.apellidos,
    required this.fechaNacimiento,
    required this.direccion,
    required this.comuna,
    required this.telefono,
    required this.correo,
    required this.zonaSeleccionada,
  });
}
