import 'package:bizcard_app/utils/utils.dart';

class AnalyticsLog {
  final int count;
  final String date;

  const AnalyticsLog({
    required this.count,
    required this.date,
  });

  factory AnalyticsLog.fromJson(Map<String, dynamic> map) {
    return AnalyticsLog(
      count: map['count'] as int,
      date: formatDate(map['date']),
    );
  }
}
