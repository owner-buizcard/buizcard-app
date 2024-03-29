import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFieldWL extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final bool isRequired;
  final String? validationType;
  final String? prefixText;
  final String? hint;
  final bool autofocus;
  final int maxLines;
  final TextEditingController controller;
  final Function(String)? onChanged;
  const InputFieldWL({
    super.key, 
    required this.label, 
    this.hint,
    this.prefixText,
    this.onChanged,
    this.autofocus = false,
    required this.controller,
    this.isRequired = false,
    this.maxLines = 1,
    this.validationType,
    this.prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '$label ${isRequired ? '*' : ''}'.btext(context, color: 'dark'),
        const Gap(size: 10),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.roboto(
            fontSize: 17,
            color: Colors.black
          ),
          onChanged: onChanged,
          autofocus: autofocus,
          decoration: InputDecoration(
            prefixIcon: prefixIcon!=null 
              ? Icon(prefixIcon) : prefixText!=null ? Container(width: 90, alignment: Alignment.center, child: Text(prefixText!)): null,
            errorMaxLines: 2,
            hintText: hint,
            filled: true,
            fillColor: Colors.white
          ),
          validator: (val){
            if(validationType=='email'){
              return Validator.validateEmail(val);
            }else if(validationType=='password'){
              return Validator.validatePassword(val);
            }else if(isRequired){
              return Validator.validateNonNull(val, label);
            }
            return null;
          },
        )
      ],
    );
  }
}