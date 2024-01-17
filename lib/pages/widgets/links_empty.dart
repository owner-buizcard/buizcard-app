import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class LinksEmpty extends StatelessWidget {
  final String cardId;
  const LinksEmpty({super.key, required this.cardId});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 180
          ),
          child: OutlinedButton(
            onPressed: ()=>Navigator.pushNamed(context, Routes.linkStore,  arguments: cardId), 
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(AntIcons.plusCircleOutlined),
                Gap(size: 16),
                Text('Add Links')
              ],
            )),
        ),
        const Gap(size: 30),        
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 250
          ),
          child:const Text(
            'Add Contact Info, Links & more to your digital card',
            textAlign: TextAlign.center,
          )
        )
      ],
    );
  }
}