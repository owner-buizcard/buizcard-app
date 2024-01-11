import 'package:bizcard_app/utils/validator.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final bool isRequired;
  final String? validationType;
  final int? maxLines;
  final TextEditingController controller;
  const InputField({
    super.key, 
    required this.label, 
    required this.controller,
    this.isRequired = false,
    this.validationType,
    this.maxLines,
    this.prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: prefixIcon!=null 
          ? Icon(prefixIcon) : null,
        errorMaxLines: 2,
        labelText: label,
        alignLabelWithHint: true
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
    );
  }
}