import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/gap.dart';
import '../../widgets/input_field.dart';

class MyContactsFragment extends StatelessWidget {
  final DashboardViewModel viewModel;
  const MyContactsFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Contacts', style: GoogleFonts.roboto(
            fontSize: 28,
            fontWeight: FontWeight.w700
          )),
          const Gap(size: 16),
          InputField(
            hint: 'Search contacts...', 
            suffixIcon: AntIcons.searchOutlined,
            controller: TextEditingController()
          ),
          const Gap(size: 16),
          Expanded(child: ListView(
            children: [
              ContactItem(
                onOptionsClick: (v)=>viewModel.openContactOptions(context),
              )
            ],
          ))
        ])
    );
  }
}