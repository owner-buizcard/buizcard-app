import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends BaseViewModel {
  
  final List options = [
    {'title': 'Account'},
    {'icon': AntIcons.editOutlined, 'label': 'Edit Account', 'color': null},
    {'icon': AntIcons.crownOutlined, 'label': 'Upgrade to Pro', 'color': null},
    {'icon': AntIcons.lineChartOutlined, 'label': 'My Analytics', 'color': null},
    {'title': 'Features'},
    {'icon': AntIcons.apiOutlined, 'label': 'Integrations', 'color': null},
    {'icon': AntIcons.editOutlined, 'label': 'Create email signature', 'color': null},
    {'icon': AntIcons.pictureOutlined, 'label': 'Create virtual background', 'color': null},
    {'icon': AntIcons.mailOutlined, 'label': 'Follow up email', 'color': null},
    {'icon': AntIcons.aliwangwangOutlined, 'label': 'Remove branding', 'color': null},
    {'title': 'Support'},
    {'icon': AntIcons.messageOutlined, 'label': 'Request a feature', 'color': null},
    {'icon': AntIcons.questionCircleOutlined, 'label': 'Help & support', 'color': null},
    {'title': 'Account'},
    {'icon': AntIcons.userDeleteOutlined, 'label': 'Delete account', 'color': Colors.red},

  ];
  
  @override
  void dispose() {

  }

}