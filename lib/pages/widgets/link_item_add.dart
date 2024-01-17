import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/models/field.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';

class LinkItemAdd extends StatelessWidget {
  final Function(String) onAdd;
  final Field field;
  const LinkItemAdd({super.key, required this.onAdd, required this.field});

  @override
  Widget build(BuildContext context) {
    return MainCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/bizcard-web.appspot.com/o/${field.icon}',
            width: 36,
            height: 36  
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: field.label.bltext(context, color: 'darker'),
            ),
          ),
          InkWell(
            onTap: ()=>onAdd(''),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0x268c8c8c),
                borderRadius: BorderRadius.circular(5)
              ),
              child: 'Add'.btext(context, color: 'dark')
            ),
          )
        ],
      ));
  }
}