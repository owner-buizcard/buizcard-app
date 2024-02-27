import 'package:bizcard_app/constants/assets_const.dart';
import 'package:bizcard_app/constants/urls_const.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

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
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: ()async{
                var key = e['key'];
                var authLink = key=='google'
                  ? UrlsConst.googleAuth : key=='github' ? UrlsConst.githubAuth : UrlsConst.linkedinAuth;
                await launchUrlString(authLink);
              },
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Image.asset(e['icon']),
              ),
            ),
          );
        } else {
          return const Gap(size: 20);
        }
      }).toList(),
    );
  }
}
