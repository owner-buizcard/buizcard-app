import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/contact_item.dart';
import 'package:bizcard_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/assets_const.dart';
import '../../../routes/app_routes.dart';
import '../../contacts/bloc/contacts_bloc.dart';
import '../../widgets/gap.dart';

class MyContactsFragment extends StatelessWidget {
  final DashboardViewModel viewModel;
  const MyContactsFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactsBloc, ContactsState>(
      listener: (context, state) {
        if (state is Exported) {
          toast('Exported success!', success: true);
        } else if (state is MailSent) {
          Navigator.pop(context);
          toast('Mail sent successfully!', success: true);
        }
      },
      child: Column(
        children: [
           AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Image.asset(AssetsConst.appLogo, width: 36),
                const Gap(size: 24),
                Text('Contacts', style: GoogleFonts.inter().copyWith(
                  fontSize: 20,
                  height: 0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                )),
              ],
            ),
            actions: [
                IconButton(
                  icon: const Icon(AntIcons.exportOutlined),
                  onPressed: ()=>viewModel.openExportSheet(context, null),
                ),
                IconButton(
                  icon: const Icon(AntIcons.userAddOutlined),
                  onPressed: ()=>Navigator.pushNamed(context, Routes.createContact),
                ),
                const Gap(size: 16)
            ],
          ),

          Expanded(
              child: ValueListenableBuilder(
                valueListenable: viewModel.contacts,
                builder: (_, val, __) {
                  return ListView(
                      padding: const EdgeInsets.all(16),
                      children: val.map((e) => ContactItem(
                        contact: e,
                        onOptionsClick: (v) => viewModel
                            .openContactOptions(e, context, viewModel),
                      ))
                  .toList());
                }
              ))
        ],
      ),
    );
  }
}
