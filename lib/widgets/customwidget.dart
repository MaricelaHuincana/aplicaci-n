import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color circleColor;
  final Color textColor;

  const CustomWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.circleColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: circleColor,
            child: Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 7,
          ),
        ),
      ],
    );
  }
}

class CusWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color circleColor;
  final Color textColor;

  const CusWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.circleColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: circleColor,
            child: Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 7,
          ),
        ),
      ],
    );
  }
}

class WelcomeTextWidget extends StatelessWidget {
  final String welcomeText;
  final String reservationText;

  const WelcomeTextWidget({
    Key? key,
    required this.welcomeText,
    required this.reservationText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 0.5),
        Text(
          welcomeText,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: Color(0xFFAD4409),
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 0.5),
        Text(
          reservationText,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: Color(0xFF112F6A),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 0.5),
      ],
    );
  }
}
