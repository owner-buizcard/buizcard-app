import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/constants/colors_const.dart';
import 'package:bizcard_app/constants/constants.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/models/integration.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';

class ExportSheet extends StatelessWidget {
  final bool isAll;
  final Function(String) onClick;
  const ExportSheet({super.key, required this.onClick, required this.isAll});

  @override
  Widget build(BuildContext context) {

    var user = Global.user!;
    List<Integration> items = Global.integrations.where((element) => element.group=="CRM" && user.integrations.contains(element.id)).toList();
    items.addAll(Constants.defaultExports);

    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              
              Row(
                children: [
                  InkWell(onTap: ()=>Navigator.pop(context), child: const Icon(AntIcons.arrowLeftOutlined)),
                  const Gap(size: 16),
                  Expanded(child: Text(
                    isAll ? 'Export All' : 'Export Contact', style: Theme.of(context).textTheme.titleSmall,))
                ],
              ),

              const Gap(size: 32),

              ...items.map((e) => 
                InkWell(
                  onTap: ()=>onClick(e.id),
                  child: MainCard(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          child: Image.network(e.image, width: 40),
                        ),
                        const Gap(size: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Export to ${e.name}'.bltext(context, color: 'darker'),
                            ],
                          )
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, color: ColorsConst.greyLight,)
                      ],
                    ),
                  ),
                )).toList()
            ]
          ),
        ),
      ],
    );
  }
}