import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/settings/integrations/integration_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IntegrationView extends StatefulWidget {
  const IntegrationView({super.key});

  @override
  State<IntegrationView> createState() => _IntegrationViewState();
}

class _IntegrationViewState extends State<IntegrationView> {
  late IntegrationViewModel _viewModel;

  @override
  void initState() {
    _viewModel = IntegrationViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrations'),
      ),
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
                        onPressed: ()async{

                          if(e.authType=="api"){
                            _viewModel.openWhatsappSheet(context, _viewModel);
                            return;
                          }

                          var link = e.authLink;
                          if(e.authLink.contains('userId')){
                            link = e.authLink.replaceAll('\${userId}', Global.user!.id);
                          }
                          await launchUrlString(link);
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