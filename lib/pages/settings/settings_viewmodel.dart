import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/pages/settings/bottomsheets/confirm_sheet.dart';
import 'package:bizcard_app/pages/settings/bottomsheets/feedback_sheet.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bizcard_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/settings_bloc.dart';

class SettingsViewModel extends BaseViewModel {

  late TextEditingController controller;
  late ValueNotifier switchValues;
  final ValueNotifier notifier = ValueNotifier(false);

  SettingsViewModel(){
    controller = TextEditingController();
    switchValues = ValueNotifier({'followUp': Global.user!.followUp, 'branding': Global.user!.branding});
  }
  
  final List options = [
    {'title': 'Account'},
    {'icon': AntIcons.editOutlined, 'label': 'Edit Account', 'color': null, 'isCustom': false,},
    {'icon': AntIcons.linkOutlined, 'label': 'Personalized Link', 'color': null, 'isCustom': false,},
    {'icon': AntIcons.crownOutlined, 'label': 'Upgrade to Pro', 'color': null, 'isCustom': false,},
    {'icon': AntIcons.lineChartOutlined, 'label': 'My Analytics', 'color': null, 'isCustom': false,},
    {'icon': AntIcons.checkCircleOutlined, 'label': 'Verify Email', 'color': null, 'isCustom': false, 'isBtn': true},
    {'title': 'Features'},
    {'icon': AntIcons.apiOutlined, 'label': 'Integrations', 'color': null, 'isCustom': false},
    { 
      'icon': AntIcons.mailOutlined, 
      'label': 'Follow up email', 
      'isCustom': true,
      'color': null
    },
    {
      'icon': AntIcons.aliwangwangOutlined, 
      'label': 'Remove branding', 
      'isCustom': true,
      'color': null
    },
    {'title': 'Support'},
    {'icon': AntIcons.messageOutlined, 'label': 'Request a feature', 'color': null, 'isCustom': false,},
    {'icon': AntIcons.questionCircleOutlined, 'label': 'Help & support', 'color': null, 'isCustom': false,},
    {'title': 'Account'},
    {'icon': AntIcons.userDeleteOutlined, 'label': 'Delete account', 'color': Colors.red, 'isCustom': false,}
  ];


  confirmSheet(BuildContext context){
    controller.clear();
    showModalBottomSheet(
      context: context, 
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (_){
        return ConfirmSheet(
          controller: controller,
          notifier: notifier,
          onDelete: (){
            context.read<SettingsBloc>().add(DeleteAccountEvent());
          });
      });
  }

  feedbackSheet(BuildContext context, String type){
    controller.clear();
    showModalBottomSheet(
      context: context, 
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (_){
        return FeedbackSheet(
          type: type,
          controller: controller,
          notifier: notifier,
          onSend: (){
            Navigator.pop(context);
            context.read<SettingsBloc>().add(FeedbackEvent(text: controller.trim(), type: type));
            toast('Thanks! We will reach you soon!', success: true);
          });
      });
  }

  
  
  @override
  void dispose() {

  }

}