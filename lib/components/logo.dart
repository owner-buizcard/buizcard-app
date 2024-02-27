import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../constants/assets_const.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 50,
      child: DottedBorder(
        padding: const EdgeInsets.all(6),
        dashPattern: const [4, 4, 4],
        child: Center(
          child: Image.asset(AssetsConst.logomin, width: 40,),
        )
      ),
    );
  }
}