import 'package:flutter/material.dart';

class CustomNavigationButtons extends StatelessWidget {
  const CustomNavigationButtons({
    Key? key,
    required this.onBackPressed,
    required this.onNextPressed,
  }) : super(key: key);

  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: onBackPressed,
          icon: const Icon(Icons.arrow_back, color: Color(0xFF009DDD)),
          label: const Text(
            '   Volver   ',
            style: TextStyle(
                color: Color(0xFF009DDD),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(
                color: Color(0xFF009DDD)), 
          ),
        ),
        TextButton.icon(
          onPressed: onNextPressed,
          icon: const Row(
            children: [
              Text(
                'Siguiente',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                  width: 8),
            ],
          ),
          label: const Icon(Icons.arrow_forward, color: Colors.white),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF2F5FE1),
          ),
        ),
      ],
    );
  }
}




