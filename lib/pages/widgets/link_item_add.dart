import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LinkItemAdd extends StatelessWidget {
  final Function(String) onAdd;
  const LinkItemAdd({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return MainCard(
      child: Row(
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/bizcard-web.appspot.com/o/cardbuilder%2Ficons%2Fsocial%2Flinkedin.png?alt=media&token=ff7f47d2-4397-4ce3-aa26-068e4429cf5d',
            width: 36,
            height: 36  
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text('Linkedin', style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w600
              )),
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