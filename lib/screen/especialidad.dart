import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_2/widgets/custombuttons.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EspecialidadScreen extends StatefulWidget {
  const EspecialidadScreen({Key? key}) : super(key: key);

  @override
  _EspecialidadScreenState createState() => _EspecialidadScreenState();
}

class _EspecialidadScreenState extends State<EspecialidadScreen> {
  String selectedSpeciality = '';
  String selectedCategory = '';
  String? selectedLocation;

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
            'assets/3.png',
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
                circleColor: index == 1
                    ? const Color(0xFF112F6A)
                    : const Color(0xFFB0E1F4),
                textColor: index == 1
                    ? const Color(0xFF112F6A)
                    : const Color(0xFFB0E1F4),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            '¿Qué tipo de especialista necesitas? ',
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCategoryRadioButton('Adulto', 'adulto'),
              const SizedBox(width: 50),
              _buildCategoryRadioButton('Pediatra', 'pediatra'),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _showSpecialityDialog(context);
            },
            child: Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Text(
                    selectedSpeciality.isNotEmpty
                        ? selectedSpeciality
                        : 'Selecciona una especialidad',
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down, color: Color(0xFF000000)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 150),
          CustomNavigationButtons(
            onBackPressed: () {
              Navigator.pushNamed(context, 'zona');
            },
            onNextPressed: () async {
              if (selectedSpeciality.isNotEmpty &&
                  selectedCategory.isNotEmpty) {
                await _saveSpecialityToStrapi(
                    selectedSpeciality, selectedCategory);
                Navigator.pushNamed(context, 'profecional');
              } else {
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRadioButton(String label, String value) {
    return Row(
      children: [
        Radio(
          activeColor: const Color(0xFF066699),
          value: value,
          groupValue: selectedCategory,
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue as String;
              selectedSpeciality = '';
            });
          },
        ),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF000000),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  void _showSpecialityDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.73,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              width: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(0.0),
                ),
                color: Colors.white,
              ),
              child: ListView(
                controller: scrollController,
                shrinkWrap: true,
                children: [
                  const ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Selecciona una especialidad',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 14),
                        Icon(Icons.arrow_drop_up_outlined, color: Colors.black),
                      ],
                    ),
                  ),
                  _buildSpecialityItem('Urología', 'adulto'),
                  _buildSpecialityItem('Medicina General', 'adulto'),
                  _buildSpecialityItem('Ginecología y Obstetricia', 'adulto'),
                  _buildSpecialityItem('Bronco Pulmonar', 'pediatra'),
                  _buildSpecialityItem('Cardiología', 'pediatra'),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSpecialityItem(String speciality, String category) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSpeciality = speciality;
          selectedCategory = category;
        });
        Navigator.pop(context);
      },
      child: ListTile(
        title: Text(
          speciality,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Future<void> _saveSpecialityToStrapi(
      String speciality, String category) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://localhost:1337/api/especialidads'));
    request.body = json.encode({
      "data": {
        "id_especialidad": "5", 
        "Nombre_especialidad": speciality,
        "id_profecional": 3, 
        "especialista": category
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
