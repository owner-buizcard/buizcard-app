import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Map item;
  final Function(String) onClick;
  const ListItem({super.key, required this.item, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: ()=>onClick(item["label"]),
        leading: Icon(item["icon"], color: item["color"]),
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: '${item["label"]}'.bltext(context, color: 'darker')
        ),
      ),
    );
  }
}