import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../utils/global.dart';
import '../widgets/gap.dart';
import '../widgets/main_card.dart';

class ExportView extends StatefulWidget {
  const ExportView({super.key});

  @override
  State<ExportView> createState() => _ExportViewState();
}

class _ExportViewState extends State<ExportView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: Global.integrations.map(
          (e){

            bool isConnected = Global.user!.integrations.contains(e.id);

            return MainCard(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(e.image, width: 44),
                    const Gap(size: 16),
                    Visibility(
                      visible: !isConnected,
                      replacement: const Icon(AntIcons.checkCircleFilled, color: Colors.green, size: 32),
                      child: SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                            padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
                          ),
                        onPressed: isConnected ? null: ()async{
                          Navigator.pushNamed(context, Routes.launchView, arguments: e.authLink);
                        }, 
                        child: Text(isConnected ? 'Connected': 'Connect'))
                      ),  
                    )
                  ],
                ),
                const Gap(size: 16),
                Text(e.name, style: Theme.of(context).textTheme.labelSmall),
                const Gap(size: 8),
                e.description.bltext(context),
              ],
            )
            
            );
          }).toList(),
      ),
    );
  }
}