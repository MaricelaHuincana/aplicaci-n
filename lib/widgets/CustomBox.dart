import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const CustomBox({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.enabled = true,
    this.validator,
    this.onTap,
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
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            validator: validator,
            onTap: onTap,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Color(0xFF003FA6),
              fontSize: 12,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF828282)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.1, horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }
}
