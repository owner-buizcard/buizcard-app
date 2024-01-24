import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/models/contact.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';

import '../../constants/colors_const.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function(String) onOptionsClick;
  const ContactItem({super.key, required this.onOptionsClick, required this.contact});

  @override
  Widget build(BuildContext context) {

    return MainCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: ColorsConst.border,
            backgroundImage: (contact.card?.picture!=null) ? NetworkImage(contact.card!.picture!) : null,
            child: contact.card?.picture==null ? const Icon(Icons.person, size: 34) : null,
          ),
          const Gap(size: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (contact.card!=null? '${contact.card?.name?.firstName} ${contact.card?.name?.lastName}': contact.details?.name??'').titletext(context),
                const Gap(size: 2),
                (contact.card!=null? '${contact.card?.phoneNumber??contact.card?.email}': contact.details?.phone??contact.details?.email??'').bltext(context)
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