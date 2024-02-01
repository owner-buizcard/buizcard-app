import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/models/analytics.dart';
import 'package:flutter/material.dart';

class CardAnalyticsViewModel extends BaseViewModel {
  
  late List data;
  late BuildContext context;
  

  CardAnalyticsViewModel(this.context){
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
      }
    ];
  }

  List<Color> gradientColors = [
    Colors.green,
    Colors.yellow,
  ];

  initialize(Analytics analytics){
    data[0]['count'] = analytics.viewCount;
    data[1]['count'] = analytics.uniqueVisitCount;
    data[2]['count'] = analytics.savedCount;
    data[3]['count'] = analytics.webClickCount;
  }


  @override
  void dispose() {
  
  }
}