import 'package:flutter/material.dart';

class BannerPH extends StatelessWidget {
  const BannerPH({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(8)
      ),
      padding: const EdgeInsets.only(right: 60),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: 90,
            color: const Color(0xFFB0B0B0),
          ),
          Container(
            width: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(50)
              )
            ),
          )
        ],
      ),
    );
  }
}