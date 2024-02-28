import 'package:bizcard_app/models/totals.dart';
import 'package:equatable/equatable.dart';

class AppAnalytics extends Equatable {
  final Totals totals;
  final List sortedCards;

  const AppAnalytics({
    required this.totals,
    required this.sortedCards
  });


  AppAnalytics copyWith({
    Totals? totals,
    List? sortedCards
  }) {
    return AppAnalytics(
      totals: totals ?? this.totals,
      sortedCards: sortedCards ?? this.sortedCards
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'totals': totals,
      'sortedCards': sortedCards
    };
  }

  factory AppAnalytics.fromJson(Map<String, dynamic> map) {
    return AppAnalytics(
      totals: Totals.fromJson(map['totals']),
      sortedCards: map['sortedCards'] ?? []
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [];
  }
}
