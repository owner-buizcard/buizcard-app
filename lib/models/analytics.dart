import 'package:bizcard_app/models/analytics_log.dart';
import 'package:equatable/equatable.dart';

class Analytics extends Equatable {
  final String cardId;
  final int viewCount;
  final int uniqueVisitCount;
  final int savedCount;
  final int sharedCount;
  final int connectedCount;
  final int webClickCount;
  final List<AnalyticsLog> weekLogViews;
  final List<AnalyticsLog> weekLogSave;

  const Analytics({
    required this.cardId,
    required this.viewCount,
    required this.uniqueVisitCount,
    required this.savedCount,
    required this.sharedCount,
    required this.connectedCount,
    required this.webClickCount,
    required this.weekLogViews,
    required this.weekLogSave,
  });


  Analytics copyWith({
    String? cardId,
    int? viewCount,
    int? uniqueVisitCount,
    int? savedCount,
    int? sharedCount,
    int? connectedCount,
    int? webClickCount,
    List<AnalyticsLog>? weekLogViews,
    List<AnalyticsLog>? weekLogSave,
  }) {
    return Analytics(
      cardId: cardId ?? this.cardId,
      viewCount: viewCount ?? this.viewCount,
      uniqueVisitCount: uniqueVisitCount ?? this.uniqueVisitCount,
      savedCount: savedCount ?? this.savedCount,
      sharedCount: sharedCount ?? this.sharedCount,
      connectedCount: connectedCount ?? this.connectedCount,
      webClickCount: webClickCount ?? this.webClickCount,
      weekLogViews: weekLogViews ?? this.weekLogViews,
      weekLogSave: weekLogSave ?? this.weekLogSave,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cardId': cardId,
      'viewCount': viewCount,
      'uniqueVisitCount': uniqueVisitCount,
      'savedCount': savedCount,
      'sharedCount': sharedCount,
      'connectedCount': connectedCount,
      'webClickCount': webClickCount,
      'weekLogViews': weekLogViews,
      'weekLogSave': weekLogSave,
    };
  }

  factory Analytics.fromJson(Map<String, dynamic> map) {
    return Analytics(
      cardId: map['cardId'] as String,
      viewCount: map['viewCount'] as int,
      uniqueVisitCount: map['uniqueVisitCount'] as int,
      savedCount: map['savedCount'] as int,
      sharedCount: map['sharedCount'] as int,
      connectedCount: map['connectedCount'] as int,
      webClickCount: map['webClickCount'] as int,
      weekLogViews: map['weekLogViews']!=null ? (map['weekLogViews'] as List).map((e) => AnalyticsLog.fromJson(e)).toList(): [],
      weekLogSave: map['weekLogSave']!=null ? (map['weekLogSave'] as List).map((e) => AnalyticsLog.fromJson(e)).toList(): [],
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      cardId,
      viewCount,
      uniqueVisitCount,
      savedCount,
      sharedCount,
      connectedCount,
      webClickCount,
      weekLogViews,
      weekLogSave,
    ];
  }
}
