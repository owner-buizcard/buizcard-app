import 'package:bizcard_app/models/contact.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function(String) onOptionsClick;
  const ContactItem({super.key, required this.onOptionsClick, required this.contact});

  @override
  Widget build(BuildContext context) {

    return MainCard(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[300],
            backgroundImage: (contact.card?.picture!=null) ? NetworkImage(contact.card!.picture!) : null,
            child: contact.card?.picture==null ? const Icon(Icons.person, size: 28) : null,
          ),
          const Gap(size: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((contact.card!=null? '${contact.card?.name?.firstName} ${contact.card?.name?.lastName}': contact.details?.name??''), style: GoogleFonts.inter().copyWith(
                  fontSize: 16,
                  height: 0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87
                )),
                const Gap(size: 8),
                Text((contact.card!=null? '${contact.card?.phoneNumber??contact.card?.email}': contact.details?.phone??contact.details?.email??''), style: GoogleFonts.inter().copyWith(
                  fontSize: 14,
                  height: 0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54
                )),
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