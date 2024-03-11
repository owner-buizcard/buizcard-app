import 'package:bizcard_app/constants/colors_const.dart';
import 'package:bizcard_app/pages/widgets/link_item_edit.dart';
import 'package:bizcard_app/pages/widgets/links_empty.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/gap.dart';
import '../card_builder_viewmodel.dart';

class LinksFragment extends StatelessWidget {
  final CardBuilderViewModel viewModel;
  const LinksFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: viewModel.fields,
        builder: (_, value, __) {
          if (value.isEmpty) {
            return LinksEmpty(cardId: viewModel.card.id, viewModel: viewModel);
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 45),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Added Links',
                      style: Theme.of(context).textTheme.titleMedium),
                  InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, Routes.linkStore, arguments: viewModel.card.id);
                      viewModel.openLinkStore(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text("Add New",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorsConst.primary)),
                    ),
                  )
                ],
              ),
              const Gap(size: 20),
              Column(
                children: [
                  ...value
                      .map((e) => LinkItemEdit(
                            field: e,
                            onEdit: (v) =>
                                viewModel.openSheet(context, e, viewModel),
                          ))
                      .toList()
                ],
              )
            ],
          );
        });
  }
}
