import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/settings/settings_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/list_item.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors_const.dart';
import '../../database/local_db.dart';
import '../widgets/gap.dart';
import 'bloc/settings_bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SettingsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = SettingsViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 30,
        backgroundColor: Colors.transparent,
        title: const Text('Settings'),
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) async{
          if(state is AccountDeleted){
            await LocalDB.clearDB().then((_) =>
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.login, (route) => false));
          }
        },
        child: ListView(
          children: [
            SizedBox(
              height: 120,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 80,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x268c8c8c),
                                blurRadius: 8,
                                offset: Offset(0, -2))
                          ],
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24))),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundImage: Global.user!.picture != null
                          ? NetworkImage(Global.user!.picture!)
                          : null,
                      backgroundColor: ColorsConst.border,
                      child: Global.user!.picture != null
                          ? null
                          : const Icon(AntIcons.userOutlined),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _viewModel.options.map((e) {
                  if (e["title"] == null) {
                    return ListItem(
                        item: e,
                        onClick: (v) {
                          if (v == "Integrations") {
                            Navigator.pushNamed(context, Routes.integrations);
                          } else if (v == "Delete account") {
                            _viewModel.confirmSheet(context);
                          }
                        });
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('${e["title"]}',
                          style: Theme.of(context).textTheme.labelSmall),
                    );
                  }
                }).toList(),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await LocalDB.clearDB().then((_) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.login, (route) => false));
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: const Color(0x268c8c8c),
                          borderRadius: BorderRadius.circular(8)),
                      child: 'Signout'.bltext(context, color: 'darker'),
                    ),
                  ),
                  const Gap(
                    size: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Version 1.0.0 -',
                          style: GoogleFonts.roboto(
                              color: const Color(0xff000000),
                              fontSize: 13,
                              fontWeight: FontWeight.w400)),
                      Text('Terms & Privacy',
                          style: GoogleFonts.roboto(
                              color: const Color(0xff000000),
                              fontSize: 13,
                              fontWeight: FontWeight.w600))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
