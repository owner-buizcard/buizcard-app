import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  const InputField({
    super.key, required this.label, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const Gap(size: 10),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon)
          ),
        )
      ],
    );
  }
}