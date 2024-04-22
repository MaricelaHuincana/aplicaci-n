import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/confirmacion.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_2/widgets/CustomBox.dart';
import 'package:flutter_application_2/widgets/custombuttons.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';

class DatosPersonalesScreen extends StatefulWidget {
  const DatosPersonalesScreen({Key? key}) : super(key: key);

  @override
  _DatosPersonalesScreenState createState() => _DatosPersonalesScreenState();
}

class _DatosPersonalesScreenState extends State<DatosPersonalesScreen> {
  TextEditingController identificationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController communeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  DateTime? selectedDate;
  String? zonaSeleccionada;
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
      birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    });
  }
}

  Future<void> enviarDatosAlServidor() async {
    // Obtener los valores del formulario
    String id = identificationController.text;
    String nombre = nameController.text;
    String apellido = lastNameController.text;
    String fechaNacimiento = birthDateController.text;
    String direccion = addressController.text;
    String comuna = communeController.text;
    String telefono = phoneNumberController.text;
    String correo = emailController.text;

    // Crear un mapa con los datos del formulario
    Map<String, dynamic> formData = {
      "data": {
        "id_alfanumerica": id,
        "nombre": nombre,
        "apellido": apellido,
        "fecha_nacimiento": fechaNacimiento,
        "direccion": direccion,
        "comuna": comuna,
        "numero_telefono": telefono,
        "correo_electronico": correo,
        "agenda_medica": 1
      }
    };

    // Convertir el mapa a JSON
    String jsonData = json.encode(formData);

    // Realizar la solicitud POST
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://localhost:1337/api/pacientes'));
    request.headers.addAll(headers);
    request.body = jsonData;

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    circleColor: index == 5
                        ? const Color(0xFF112F6A)
                        : const Color(0xFFB0E1F4),
                    textColor: index == 5
                        ? const Color(0xFF112F6A)
                        : const Color(0xFFB0E1F4),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Ingrese tus datos personales',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
                labelText: 'Nombres',
                hintText: 'Ingresa tu Nombre',
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre';
                  }

                  RegExp regex = RegExp(r'^[a-zA-Z]+$');
                  if (!regex.hasMatch(value)) {
                    return 'El nombre solo debe contener letras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomBox(
                labelText: 'Apellidos',
                hintText: 'Ingresa tu Apellido',
                controller: lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu apellido';
                  }

                  RegExp regex = RegExp(r'^[a-zA-Z]+$');
                  if (!regex.hasMatch(value)) {
                    return 'El apellido solo debe contener letras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => _selectDate(context),
                child: CustomBox(
                  labelText: 'Fecha de cumpleaños',
                  hintText: selectedDate != null
                      ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                      : 'Selecciona tu fecha de nacimiento',
                  controller: birthDateController,
                  enabled: true,
                ),
              ),
              const SizedBox(height: 10),
              CustomBox(
                labelText: 'Dirección',
                hintText: 'Ingresa tu Dirección',
                controller: addressController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu dirección';
                  }

                  RegExp regex = RegExp(r'^[a-zA-Z0-9\s]+$');
                  if (!regex.hasMatch(value)) {
                    return 'La dirección debe contener letras y números';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomBox(
                labelText: 'Comuna',
                hintText: 'Ingresa tu Comuna',
                controller: communeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu comuna';
                  }

                  RegExp regex = RegExp(r'^[a-zA-Z]+$');
                  if (!regex.hasMatch(value)) {
                    return 'El comuna solo debe contener letras';
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
              const SizedBox(height: 10),
              const SizedBox(height: 24),
              CustomNavigationButtons(
                onBackPressed: () {
                  Navigator.pushNamed(context, 'hora');
                },
                onNextPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Enviar los datos al servidor
                    await enviarDatosAlServidor();

                    Navigator.pushNamed(
                      context,
                      'confirmacion',
                      arguments: ConfirmacionArguments(
                        identificacion: identificationController.text,
                        nombres: nameController.text,
                        apellidos: lastNameController.text,
                        fechaNacimiento: selectedDate,
                        direccion: addressController.text,
                        comuna: communeController.text,
                        telefono: phoneNumberController.text,
                        correo: emailController.text,
                        zonaSeleccionada: zonaSeleccionada ?? '',
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
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
