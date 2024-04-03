import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/custombuttons.dart';
import 'package:flutter_application_2/widgets/customwidget.dart';

class ZonaScreen extends StatefulWidget {
  ZonaScreen({Key? key}) : super(key: key);

  @override
  _ZonaScreenState createState() => _ZonaScreenState();
}

class _ZonaScreenState extends State<ZonaScreen> {
  String? selectedLocation;
  bool checkBoxValue = false;

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
                  color: Color(0xFF112F6A),
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
            onNextPressed: selectedLocation != null && checkBoxValue
                ? () {
                    Navigator.pushNamed(
                      context,
                      'especialidad',
                      arguments: {
                        'zonaSeleccionada': selectedLocation!,
                      },
                    );
                  }
                : () => {},
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
                selectedLocation = value as String;
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
