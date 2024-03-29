import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/models/field_value.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';

class LinkItemEdit extends StatelessWidget {
  final Function(String) onEdit;
  final FieldValue field;
  const LinkItemEdit({super.key, required this.onEdit, required this.field});

  @override
  Widget build(BuildContext context) {
    return MainCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const Icon(AntIcons.menuOutlined, size: 20, color: Color(0xFFB0B0B0)),
          const Gap(size: 16),
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/bizcard-web.appspot.com/o/${field.icon}',
            width: 36,
            height: 36  
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: field.title.bltext(context, color: 'darker'),
            ),
          ),
          InkWell(
            onTap: ()=>onEdit(''),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0x268c8c8c),
                borderRadius: BorderRadius.circular(5)
              ),
              child: 'Edit'.btext(context, color: 'dark')
            ),
          )
        ],
      ));
  }
}