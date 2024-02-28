import 'package:equatable/equatable.dart';

class Totals extends Equatable {
  final int totalViewCount;
  final int totalUniqueVisitCount;
  final int totalSavedCount;
  final int totalSharedCount;
  final int totalConnectedCount;
  final int totalWebClickCount;
  const Totals({
    required this.totalViewCount,
    required this.totalUniqueVisitCount,
    required this.totalSavedCount,
    required this.totalSharedCount,
    required this.totalConnectedCount,
    required this.totalWebClickCount,
  });


  Totals copyWith({
    int? totalViewCount,
    int? totalUniqueVisitCount,
    int? totalSavedCount,
    int? totalSharedCount,
    int? totalConnectedCount,
    int? totalWebClickCount
  }) {
    return Totals(
      totalViewCount: totalViewCount ?? this.totalViewCount,
      totalUniqueVisitCount: totalUniqueVisitCount ?? this.totalUniqueVisitCount,
      totalSavedCount: totalSavedCount ?? this.totalSavedCount,
      totalSharedCount: totalSharedCount ?? this.totalSharedCount,
      totalConnectedCount: totalConnectedCount ?? this.totalConnectedCount,
      totalWebClickCount: totalWebClickCount ?? this.totalWebClickCount
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'totalViewCount': totalViewCount,
      'totalUniqueVisitCount': totalUniqueVisitCount,
      'totalSavedCount': totalSavedCount,
      'totalSharedCount': totalSharedCount,
      'totalConnectedCount': totalConnectedCount,
      'totalWebClickCount': totalWebClickCount
    };
  }

  factory Totals.fromJson(Map<String, dynamic> map) {
    return Totals(
      totalViewCount: map['totalViewCount'] as int,
      totalUniqueVisitCount: map['totalUniqueVisitCount'] as int,
      totalSavedCount: map['totalSavedCount'] as int,
      totalSharedCount: map['totalSharedCount'] as int,
      totalConnectedCount: map['totalConnectedCount'] as int,
      totalWebClickCount: map['totalWebClickCount'] as int
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      totalViewCount,
      totalUniqueVisitCount,
      totalSavedCount,
      totalSharedCount,
      totalConnectedCount,
      totalWebClickCount
    ];
  }
}
