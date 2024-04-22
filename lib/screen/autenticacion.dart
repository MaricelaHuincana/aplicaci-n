import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_2/widgets/CustomBox.dart';
import 'package:flutter_application_2/widgets/alertamensaje.dart';
import 'package:flutter_application_2/widgets/custbox.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';

class AutenticacionScreen extends StatefulWidget {
  const AutenticacionScreen({Key? key}) : super(key: key);

  @override
  _AutenticacionScreenState createState() => _AutenticacionScreenState();
}

class _AutenticacionScreenState extends State<AutenticacionScreen> {
  TextEditingController identificationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool aceptaPoliticaPrivacidad = false;

  final _formKey = GlobalKey<FormState>();

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
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
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
            CustomBox(
              labelText: 'Identificación alfanumérica',
              hintText: 'Ingresa tu identificación alfanumérica',
              controller: identificationController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa tu identificación';
                }

                if (!validarRut(value)) {
                  return 'Ingresa un RUT válido';
                }

                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomBox(
              labelText: 'Número telefónico',
              hintText: 'Ingresa tu Número telefónico',
              controller: phoneNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa tu número telefónico';
                }

                RegExp regex = RegExp(r'^[0-9]{9}$');
                if (!regex.hasMatch(value)) {
                  return 'Ingresa un número telefónico válido de 9 dígitos';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomBox(
              labelText: 'Correo electrónico',
              hintText: 'Ingresa tu Correo electrónico',
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa tu correo electrónico';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Ingresa un correo válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 15),
                Checkbox(
                  value: aceptaPoliticaPrivacidad,
                  onChanged: (value) {
                    setState(() {
                      aceptaPoliticaPrivacidad = value!;
                    });
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
                if (_formKey.currentState!.validate()) {
                  if (aceptaPoliticaPrivacidad) {
                    
                    _eliminarCitaMedica(identificationController.text);
                    
                    AlertaNumero.mostrar(
                        context, 'Este es un mensaje de verificación');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Debes aceptar la política de privacidad para continuar.'),
                      ),
                    );
                  }
                }
              },
              nextButtonEnabled: aceptaPoliticaPrivacidad,
            ),
          ],
        ),
      ),
    ));
  }

  void _eliminarCitaMedica(String idAlfanumerica) async {
    var url = Uri.parse('http://localhost:1337/api/pacientes/:id');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Cita médica eliminada correctamente');
    } else {
      print('Error al eliminar la cita médica: ${response.reasonPhrase}');
    }
  }

  bool validarRut(String rut) {
    final RegExp regex = RegExp(r'^(\d{1,3}(?:\.\d{1,3}){2}-[\dkK])$');

    if (!regex.hasMatch(rut)) {
      return false;
    }

    rut = rut.replaceAll('.', '');
    rut = rut.replaceAll('-', '');

    String dv = rut.substring(rut.length - 1).toUpperCase();
    rut = rut.substring(0, rut.length - 1);

    int suma = 0;
    int multiplicador = 2;

    for (int i = rut.length - 1; i >= 0; i--) {
      suma += int.parse(rut[i]) * multiplicador;
      multiplicador = multiplicador == 7 ? 2 : multiplicador + 1;
    }

    int resto = suma % 11;
    int resultado = 11 - resto;

    String dvCalculado = resultado == 11
        ? '0'
        : resultado == 10
            ? 'K'
            : resultado.toString();

    return dv == dvCalculado;
  }
}
