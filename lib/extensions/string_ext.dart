import 'package:flutter/material.dart';

extension TextEditingControllerTrim on TextEditingController {

  String trim()=>text.trim();

}

extension StringExtensions on String? {
  String? nullIfEmpty() {
    return this?.isNotEmpty == true || this!="null" ? this : null;
  }
}

extension StringExtension on dynamic {
  String? nullIfEmpty() {
    return this??toString().isNotEmpty == true ? this : null;
  }
}
