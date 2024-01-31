import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gap.dart';

class SingleSelectWL extends StatelessWidget {
  final String label;
  final String? hint;
  final List items;
  final dynamic value;
  final Function(dynamic) onChanged;

  const SingleSelectWL({
    super.key,
    this.hint,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.btext(context, color: 'dark'),
        const Gap(size: 10),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<String>(
            isExpanded: true,
            decoration: InputDecoration(
              hintText: hint
            ),
            items: items.map((e) => DropdownMenuItem<String>(
                value: e['value'],
                child: Text(e['label']))).toList(),
            value: value,
            onChanged: onChanged,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.black
            ),
          ),
        )
      ],
    );
  }
}