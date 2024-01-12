import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/cards/links/link_store_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:bizcard_app/pages/widgets/link_item_add.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/gap.dart';

class LinkStoreView extends StatefulWidget {
  const LinkStoreView({super.key});

  @override
  State<LinkStoreView> createState() => _LinkStoreViewState();
}

class _LinkStoreViewState extends State<LinkStoreView> {
  late LinkStoreViewModel _viewModel;

  @override
  void initState() {
    _viewModel = LinkStoreViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Link Store"),
        actions: [
          TextButton(onPressed: (){}, child: const Text("Save")),
          const Gap(size: 8)
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          InputField(
            hint: 'Search links...', 
            suffixIcon: AntIcons.searchOutlined,
            controller: TextEditingController()
          ),
          const Gap(size: 16),
          Text('Recommended', style: GoogleFonts.roboto(
            color: const Color(0xFF797272),
            fontSize: 15,
          )),
          const Gap(size: 16),
          LinkItemAdd(onAdd: (v)=>_viewModel.addLink(context))
        ],
      ),
    );
  }
}