import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/Autenticacion.dart';
import 'package:flutter_application_2/screen/agendadisponible.dart';
import 'package:flutter_application_2/screen/botones.dart';
import 'package:flutter_application_2/screen/confirmacion.dart';
import 'package:flutter_application_2/screen/datospersonales.dart';
import 'package:flutter_application_2/screen/eleccion.dart';
import 'package:flutter_application_2/screen/especialidad.dart';
import 'package:flutter_application_2/screen/hora.dart';
import 'package:flutter_application_2/screen/ondoarding.dart';
import 'package:flutter_application_2/screen/profesional.dart';
import 'package:flutter_application_2/screen/verificacion.dart';
import 'package:flutter_application_2/screen/zonascreen.dart';

void main() => runApp(const MainScreen());

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'inicio',
      routes: {
        'inicio': (_) =>  OnboardingScreen(),
        'home': (_) => Botones(),
        'zona': (_) => ZonaScreen(),
        'especialidad': (_) => const EspecialidadScreen(),
        'profecional': (_) => const ProfesionalScreen(),
        'agendadisponible': (_) => const AgendaDisponibleScreen(),
        'hora': (_) => const HoraScreen(),
        'datospersonales': (_) => const DatosPersonalesScreen(),
        'confirmacion': (_) =>  ConfirmacionScreen(),
        'autenticacion': (_) => const AutenticacionScreen(),
        'verificacion': (_) => const VerificacionScreen(),
        'eleccion': (_) => const EleccionScreen()
      },
    );
  }
}
