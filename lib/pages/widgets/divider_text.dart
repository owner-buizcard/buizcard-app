import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  final String text;
  const DividerText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 16,
          child: Divider(
            color: Color(0xFFB0B0B0),
          )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(text, style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFFB0B0B0),
          ))),
        const SizedBox(
          width: 16,
          child: Divider(
            color: Color(0xFFB0B0B0),
          )),
      ],
    );
  }
}