import 'package:bizcard_app/constants/colors_const.dart';
import 'package:bizcard_app/pages/widgets/link_item_edit.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/gap.dart';
import '../card_builder_viewmodel.dart';

class LinksFragment extends StatelessWidget {
  final CardBuilderViewModel viewModel;
  const LinksFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Added Links',
              style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700, fontSize: 28)),
            InkWell(
              onTap: ()=>Navigator.pushNamed(context, Routes.linkStore),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text("Add New", style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorsConst.primary
                )),
              ),
            )
          ],
        ),
        const Gap(size: 20),

        LinkItemEdit(
          onEdit: (v)=>viewModel.editLink(context),
        )

      ],
    );
  }
}