import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Set your photo', style: Theme.of(context).textTheme.titleMedium),
          'Make your profile more engaging'.btext(context),

          const Gap(size: 80),
          
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 140,
              width: 140,
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundColor: Color(0xFFD9D9D9),
                    child: Icon(AntIcons.userOutlined, size: 40, color: Color(0xFF797272)),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(18),
                        color: const Color(0x80000000),
                      ),
                      child: const Icon(AntIcons.cameraOutlined, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Gap(size: 80),

          ElevatedButton(
            onPressed: (){}, 
            child: const Text('Continue')
          ),

          const Gap(size: 24),

          TextButton(
            onPressed: (){}, 
            child: const Text('Skip'))
        ],
      ),
    );
  }
}