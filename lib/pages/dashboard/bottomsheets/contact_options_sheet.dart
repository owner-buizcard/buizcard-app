import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/models/contact.dart';
import 'package:bizcard_app/pages/widgets/list_item.dart';
import 'package:flutter/material.dart';

class ContactOptionsSheet extends StatelessWidget {
  final Function(String) onClick;
  final Contact contact;
  const ContactOptionsSheet({super.key, required this.onClick, required this.contact});

  @override
  Widget build(BuildContext context) {

    var email = contact.card?.email??contact.details?.email;
    final List options = [
      ...contact.details!=null ? [{ 'icon': AntIcons.editOutlined, 'label': 'Edit' }]: [],
      ...contact.card!=null ? [{ 'icon': AntIcons.eyeOutlined, 'label': 'Preview' }]: [],
      { 'icon': AntIcons.paperClipOutlined, 'label': 'Add Tags' },
      ...email!=null ? [{ 'icon': AntIcons.mailOutlined, 'label': 'Send Mail' }]: [],
      { 'icon': AntIcons.downloadOutlined, 'label': 'Save as Contact' },
      { 'icon': AntIcons.exportOutlined, 'label': 'Export' },
      { 'icon': AntIcons.deleteOutlined, 'label': 'Delete', 'color': Colors.red }
    ];

    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 52,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6D6D6),
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
              ...options.map((opt)=>
                ListItem(item: opt, onClick: (v)=>onClick(v))
              ).toList()
            ]
          ),
        ),
      ],
    );
  }
}