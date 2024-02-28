import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../models/app_analytics.dart';

class AnalyticsViewModel extends BaseViewModel {
  
  late List data;
  List topCards = [];
  late BuildContext context;
  

  AnalyticsViewModel(this.context){
    data = [
      {
        "label": "Card Views",
        "count": 0,
        "icon": AntIcons.eyeOutlined
      },
      {
        "label": "Unique Visitors",
        "count": 0,
        "icon": AntIcons.userOutlined
      },
      {
        "label": "Downloads",
        "count": 0,
        "icon": AntIcons.downloadOutlined
      },
      {
        "label": "Links Taps",
        "count": 0,
        "icon": AntIcons.linkOutlined
      },
      {
        "label": "Cards Shared",
        "count": 0,
        "icon": AntIcons.shareAltOutlined
      },
      {
        "label": "Connected People",
        "count": 0,
        "icon": AntIcons.groupOutlined
      }
    ];
  }

  List<Color> gradientColors = [
    Colors.green,
    Colors.yellow,
  ];

  initialize(AppAnalytics analytics){
    data[0]['count'] = analytics.totals.totalViewCount;
    data[1]['count'] = analytics.totals.totalUniqueVisitCount;
    data[2]['count'] = analytics.totals.totalSavedCount;
    data[3]['count'] = analytics.totals.totalWebClickCount;
    data[4]['count'] = analytics.totals.totalSharedCount;
    data[5]['count'] = analytics.totals.totalConnectedCount;
    topCards = analytics.sortedCards;
  }
  
  @override
  void dispose() {

  }
}