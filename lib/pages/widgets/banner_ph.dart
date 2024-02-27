import 'package:bizcard_app/constants/assets_const.dart';
import 'package:flutter/material.dart';

class BannerPH extends StatelessWidget {
  final String? image;
  const BannerPH({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        image: image!=null
          ? DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image!))
          : const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AssetsConst.banner))
      ),
      padding: const EdgeInsets.only(right: 60)
    );
  }
}