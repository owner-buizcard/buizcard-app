import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/cards/builder/card_builder_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:bizcard_app/pages/widgets/link_item_add.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';

import '../../../models/field.dart';
import '../../widgets/gap.dart';

class LinkStoreView extends StatelessWidget {
  final String cardId;
  final Function(Field) onAdd;
  final CardBuilderViewModel viewModel;
  const LinkStoreView({super.key, required this.cardId, required this.onAdd, required this.viewModel});

  @override
  Widget build(BuildContext context) {

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height*0.8
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Link Store"),
          actions: [
            TextButton(onPressed: ()=>{
              Navigator.pop(context)
            }, child: const Text("Save")),
            const Gap(size: 8)
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            InputField(
                hint: 'Search links...',
                suffixIcon: AntIcons.searchOutlined,
                controller: TextEditingController()),
            const Gap(size: 16),
            ...Global.groupedFields.keys
                .map((e) => ValueListenableBuilder(
                  valueListenable: viewModel.fields,
                  builder: (_, fields, __) {
                    return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e,
                                  style: Theme.of(context).textTheme.labelSmall),
                              const Gap(size: 16),
                              ...Global.groupedFields[e]!
                                  .map((e) => LinkItemAdd(
                                      field: e,
                                      added: fields.any((element) => element.icon==e.icon),
                                      onAdd: (v) => onAdd(e))
                                    )
                                  .toList()
                            ]);
                  }
                ))
                .toList()
          ],
        ),
      ),
    );
  }
}
