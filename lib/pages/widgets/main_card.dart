import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsets? margin;
  final Color? color;
  const MainCard({super.key, required this.child, this.width, this.margin, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: const Color(0x268c8c8c)),
        borderRadius: BorderRadius.circular(6)
      ),
      child: child,
    );
  }
}