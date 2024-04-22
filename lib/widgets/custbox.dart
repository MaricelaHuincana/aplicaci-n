import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({
    Key? key,
    required this.onBackPressed,
    required this.onNextPressed,
    this.nextButtonEnabled = true,
  }) : super(key: key);

  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;
  final bool nextButtonEnabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: onBackPressed,
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF009DDD),
          ),
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
          onPressed: nextButtonEnabled ? onNextPressed : null,
          icon: const Row(
            children: [
              Text(
                'Confirmar',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8),
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
class CustoBox extends StatelessWidget {
  final String hintText;
  final String labelText;

  const CustoBox({
    required this.hintText,
    required this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            labelText,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF828282)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 0.1, horizontal: 12),
            child: TextField(
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color(0xFF003FA6),
                fontSize: 12,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}