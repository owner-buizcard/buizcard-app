import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/network/service/user_service.dart';
import 'package:bizcard_app/pages/settings/settings_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/list_item.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bizcard_app/utils/toast.dart';
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
        listener: (context, state) async {
          if (state is AccountDeleted) {
            await LocalDB.clearDB().then((_) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.welcome, (route) => false));
          }else if(state is SentSuccess){
            toast("Verification mail sent successfully, to registered email address!", success: true);
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
                    if (e["isCustom"]) {
                      return ValueListenableBuilder(
                          valueListenable: _viewModel.switchValues,
                          builder: (_, val, __) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: Icon(e['icon']),
                                onTap: () {
                                  if (e["label"] == "Follow up email") {
                                    var value = !_viewModel
                                        .switchValues.value['followUp'];
                                    _viewModel.switchValues.value = {
                                      ..._viewModel.switchValues.value,
                                      ...{'followUp': value}
                                    };
                                    Global.user =
                                        Global.user!.copyWith(followUp: value);
                                    UserService().updateFollowUp(value);
                                  } else {
                                    var value = !_viewModel
                                        .switchValues.value['branding'];
                                    _viewModel.switchValues.value = {
                                      ..._viewModel.switchValues.value,
                                      ...{'branding': value}
                                    };
                                    Global.user =
                                        Global.user!.copyWith(branding: value);
                                    UserService().updateBranding(value);
                                  }
                                },
                                title: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: '${e["label"]}'
                                        .bltext(context, color: 'darker')),
                                trailing: IgnorePointer(
                                  child: SizedBox(
                                      width: 20,
                                      child: SwitchListTile(
                                          value: e["label"] == "Follow up email"
                                              ? val['followUp']
                                              : !val['branding'],
                                          onChanged: (v) {})),
                                ),
                              ),
                            );
                          });
                    }
                    if (e["isBtn"] ?? false) {
                      return ValueListenableBuilder(
                          valueListenable: _viewModel.switchValues,
                          builder: (_, val, __) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: Icon(e['icon']),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                title: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: '${e["label"]}'
                                        .bltext(context, color: 'darker')),
                                trailing:
                                    Visibility(
                                      visible: Global.user!.emailVerified,
                                      replacement: BlocBuilder<SettingsBloc, SettingsState>(
                                                                        builder: (context, state) {
                                      return InkWell(
                                          onTap: () {
                                            context
                                                .read<SettingsBloc>()
                                                .add(SendVerificationEmail());
                                          },
                                          child: state is Sending 
                                            ? const SizedBox(
                                              width: 20, height: 20,
                                              child: CircularProgressIndicator(strokeWidth: 2)
                                            ) 
                                            : const Text("VERIFY"));
                                                                        },
                                                                      ),
                                      child: const Text("VERIFIED", style: TextStyle(color: Colors.green)),
                                    ),
                              ),
                            );
                          });
                    }
                    return ListItem(
                        item: e,
                        isSwitch: e["isSwitch"] ?? false,
                        onClick: (v) {
                          if (v == "Integrations") {
                            Navigator.pushNamed(context, Routes.integrations);
                          } else if (v == "Delete account") {
                            _viewModel.confirmSheet(context);
                          } else if (v == "Request a feature") {
                            _viewModel.feedbackSheet(context, "feature");
                          } else if (v == "Help & support") {
                            _viewModel.feedbackSheet(context, "support");
                          } else if (v == "My Analytics") {
                            Navigator.pushNamed(context, Routes.analytics);
                          } else if (v == "Edit Account") {
                            Navigator.pushNamed(context, Routes.editAccount);
                          } else if (v == "Upgrade to Pro") {
                            Navigator.pushNamed(context, Routes.subscriptions);
                          } else if (v == "Personalized Link") {
                            Navigator.pushNamed(context, Routes.editUsername);
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
                              context, Routes.welcome, (route) => false));
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
