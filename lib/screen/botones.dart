import 'package:flutter/material.dart';

class Botones extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF2F5FE1);

  Botones({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Rectangle 31.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 500,
              color: const Color.fromARGB(255, 253, 250, 250).withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 700,
                    height: 200,
                    child: Image.asset('assets/logo.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Encuentra la atención médica que necesitas de manera rápida y sencilla.',
                    style: TextStyle(
                      color: Color(0xFFAD4409),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Ahora puedes programar tus citas médicas de forma digital con solo unos cuantos clics.',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'zona');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kDarkBlueColor,
                      ),
                      child: const Text(
                        'Reservar hora',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'autenticacion');
                      },
                      child: const Text(
                        'Reagendar o eliminar hora',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF2F5FE1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
