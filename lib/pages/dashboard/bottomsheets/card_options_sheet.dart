import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/widgets/list_item.dart';
import 'package:flutter/material.dart';

class CardOptionsSheet extends StatelessWidget {
  final Function(String) onClick;
  const CardOptionsSheet({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {

    final List options = [
      { 'icon': AntIcons.editOutlined, 'label': 'Edit details' },
      { 'icon': AntIcons.qrcodeOutlined, 'label': 'QrCode theme' },
      { 'icon': AntIcons.settingOutlined, 'label': 'Settings' },
      { 'icon': AntIcons.eyeOutlined, 'label': 'Preview' },
      { 'icon': AntIcons.shareAltOutlined, 'label': 'Share' },
      { 'icon': AntIcons.lineChartOutlined, 'label': 'Analytics' },
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