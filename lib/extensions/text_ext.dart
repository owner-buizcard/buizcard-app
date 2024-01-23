import 'package:flutter/material.dart';


extension TextEditingControllerTrim on String {

  btext(context, {String? color, String? weight, String? align})=>Text(this, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    color: color=="dark" ? const Color(0xFF797272) : color=="darker" ? Colors.black : null,
  ), textAlign: align=='center'? TextAlign.center: null,);

  bltext(context, {String? color, String? weight})=>Text(this, style: Theme.of(context).textTheme.bodyLarge?.copyWith(
    color: color=="dark" ? const Color(0xFF797272) : color=="darker" ? Colors.black : color=='red' ? Colors.red : null,
  ));

  titletext(context)=>Text(this, style: Theme.of(context).textTheme.titleSmall);

}