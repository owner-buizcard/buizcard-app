import 'package:bizcard_app/constants/assets_const.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  final VoidCallback onClick;
  const SocialLogin({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> loginMethods = [
      {"icon": AssetsConst.google, "key": "google"},
      {},
      {"icon": AssetsConst.github, "key": "github"},
      {},
      {"icon": AssetsConst.linkedin, "key": "linkedin"}
    ];

    return Row(
      children: loginMethods.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> e = entry.value;

        if (index % 2 == 0) {
          return Expanded(
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD6D6D6)),
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.all(16),
              child: Image.asset(e['icon']),
            ),
          );
        } else {
          return const Gap(size: 20);
        }
      }).toList(),
    );
  }
}
