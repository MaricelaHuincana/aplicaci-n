import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/custombuttons.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';

class EspecialidadScreen extends StatefulWidget {
  const EspecialidadScreen({Key? key}) : super(key: key);

  @override
  _EspecialidadScreenState createState() => _EspecialidadScreenState();
}

class _EspecialidadScreenState extends State<EspecialidadScreen> {
  String selectedSpeciality =
      ''; // Variable para manejar la especialidad seleccionada
  String selectedCategory =
      ''; // Variable para manejar la categoría seleccionada (Adulto o Pediatra)
  String? selectedLocation;
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
            onNextPressed: () {
              if (selectedSpeciality.isNotEmpty) {
                // Realizar acciones según la especialidad seleccionada
                Navigator.pushNamed(context, 'profecional');
              } else {
                // Mostrar mensaje de error o manejar la situación sin selección
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
          activeColor: Color(0xFF066699),
          value: value,
          groupValue: selectedCategory,
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue as String;
              selectedSpeciality =
                  ''; // Limpiar la selección de especialidad al cambiar la categoría
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona una especialidad'),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildSpecialityItem('Urología'),
                _buildSpecialityItem('Medicina General'),
                _buildSpecialityItem('Ginecología y Obstetricia'),
                _buildSpecialityItem('Bronco Pulmonar'),
                _buildSpecialityItem('Cardiología'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpecialityItem(String speciality) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSpeciality = speciality;
        });
        Navigator.pop(context);
      },
      child: ListTile(
        title: Text(speciality),
      ),
    );
  }
}
