import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItem extends StatelessWidget {
  final Map item;
  final Function(Map) onClick;
  const ListItem({super.key, required this.item, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {},
        leading: Icon(item["icon"], color: item["color"]),
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            item["label"],
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: item["color"]
            ),
          ),
        ),
      ),
    );
  }
}