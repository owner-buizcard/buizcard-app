import 'package:bizcard_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isRequired;
  final String? validationType;
  final int maxLines;
  final Widget? suffix;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextEditingController controller;
  final VoidCallback? onSuffixIconClick;
  final bool autofocus;
  const InputField({
    super.key, 
    this.label, 
    this.hint,
    required this.controller,
    this.isRequired = false,
    this.onSuffixIconClick,
    this.autofocus = false,
    this.validationType,
    this.suffix,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      onFieldSubmitted: onFieldSubmitted,
      style: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.black
      ),
      onChanged: onChanged,
      autofocus: autofocus,
      decoration: InputDecoration(
        suffix: suffix,
        prefixIcon: prefixIcon!=null 
          ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon!=null 
          ? InkWell(
            onTap: onSuffixIconClick,
            child: Icon(suffixIcon)) : null,
        errorMaxLines: 2,
        labelText: label,
        hintText: hint,
        alignLabelWithHint: true
      ),
      validator: (val){
        if(validationType=='email'){
          return Validator.validateEmail(val);
        }else if(validationType=='password'){
          return Validator.validatePassword(val);
        }else if(isRequired){
          return Validator.validateNonNull(val, label??'');
        }
        return null;
      },
    );
  }
}