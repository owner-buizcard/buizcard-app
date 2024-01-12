import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactItem extends StatelessWidget {
  final Function(String) onOptionsClick;
  const ContactItem({super.key, required this.onOptionsClick});

  @override
  Widget build(BuildContext context) {
    return MainCard(
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/bizcard-spiderlingz.appspot.com/o/test%2Fdownload.jpeg?alt=media&token=9c3c77de-2bfa-4dab-a8e6-043cefd96871'),
          ),
          const Gap(size: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dhana Sekaran', style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w800
                )),
                const Gap(size: 2),
                Text('Flutter developer', style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: const Color(0xFFB0B0B0),
                  fontWeight: FontWeight.w400
                ))
              ],
            ),
          ),
          const Gap(size: 12),
          IconButton(
            onPressed: ()=>onOptionsClick('v'), 
            icon: const Icon(Icons.more_vert, color: Color(0xFFB0B0B0),))
        ],
      ));
  }
}