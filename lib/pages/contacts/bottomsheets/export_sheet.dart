import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';

class ExportSheet extends StatelessWidget {
  final Function(String) onClick;
  const ExportSheet({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.90,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        children: Global.integrations.map((e) => 
        InkWell(
          onTap: ()=>onClick(e.id),
          child: MainCard(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Export to ${e.name}'.bltext(context, color: 'darker'),
                      const Gap(size: 8),
                      Text(e.description)
                    ],
                  )
                ),
                const Gap(size: 16),
                SizedBox(
                  height: 100,
                  child: Image.network(e.image, width: 70),
                )
              ],
            ),
          ),
        )).toList()
      ),
    );
  }
}