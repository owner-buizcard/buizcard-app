import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LinkItemEdit extends StatelessWidget {
  final Function(String) onEdit;
  const LinkItemEdit({super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return MainCard(
      child: Row(
        children: [
          const Icon(AntIcons.menuOutlined, size: 20, color: Color(0xFFB0B0B0)),
          const Gap(size: 16),
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
            onTap: ()=>onEdit(''),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0x268c8c8c),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text('Edit', style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF797272)
              ),),
            ),
          )
        ],
      ));
  }
}