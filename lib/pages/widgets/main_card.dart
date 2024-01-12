import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  final double? width;
  const MainCard({super.key, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x268c8c8c)),
        borderRadius: BorderRadius.circular(6)
      ),
      child: child,
    );
  }
}