import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/widgets/list_item.dart';
import 'package:flutter/material.dart';

class ContactOptionsSheet extends StatelessWidget {
  const ContactOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {

    final List options = [
      { 'icon': AntIcons.editOutlined, 'label': 'Edit' },
      { 'icon': AntIcons.paperClipOutlined, 'label': 'Add Tags' },
      { 'icon': AntIcons.bookOutlined, 'label': 'Add Notes' },
      { 'icon': AntIcons.starOutlined, 'label': 'Make Favourite' },
      { 'icon': AntIcons.downloadOutlined, 'label': 'Save ad Contact' },
      { 'icon': AntIcons.shareAltOutlined, 'label': 'Share' },
      { 'icon': AntIcons.exportOutlined, 'label': 'Export' },
      { 'icon': AntIcons.deleteOutlined, 'label': 'Delete' }
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
                ListItem(item: opt, onClick: (v){})
              ).toList()
            ]
          ),
        ),
      ],
    );
  }
}