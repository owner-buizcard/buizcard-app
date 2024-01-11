import 'package:bizcard_app/pages/widgets/links_empty.dart';
import 'package:flutter/material.dart';

import '../card_builder_viewmodel.dart';

class LinksFragment extends StatelessWidget {
  final CardBuilderViewModel viewModel;
  const LinksFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return const LinksEmpty();
  }
}