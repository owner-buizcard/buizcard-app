import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/cards/links/link_store_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:bizcard_app/pages/widgets/link_item_add.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bizcard_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/gap.dart';
import '../bloc/card_bloc.dart';

class LinkStoreView extends StatefulWidget {
  final String cardId;
  const LinkStoreView({super.key, required this.cardId});

  @override
  State<LinkStoreView> createState() => _LinkStoreViewState();
}

class _LinkStoreViewState extends State<LinkStoreView> {
  late LinkStoreViewModel _viewModel;

  @override
  void initState() {
    _viewModel = LinkStoreViewModel(widget.cardId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if(state is Success){
          Navigator.pop(context);
          toast('Link added successfully!', success: true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          title: const Text("Link Store"),
          // actions: [
          //   // TextButton(onPressed: () {}, child: const Text("Save")),
          //   const Gap(size: 8)
          // ],
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
                .map((e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e,
                              style: Theme.of(context).textTheme.labelSmall),
                          const Gap(size: 16),
                          ...Global.groupedFields[e]!
                              .map((e) => LinkItemAdd(
                                  field: e,
                                  onAdd: (v) => _viewModel.openSheet(
                                      context, e, _viewModel)))
                              .toList()
                        ]))
                .toList()
          ],
        ),
      ),
    );
  }
}
