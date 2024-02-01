part of 'card_bloc.dart';

@immutable
sealed class CardState {}

final class CardInitial extends CardState {}

class Loading extends CardState {}

class Success extends CardState {}

class AnalyticsFetched extends CardState {
  final Analytics analytics;

  AnalyticsFetched({required this.analytics});
}

class CardDetailsFetched extends CardState {
  final bizcard.Card card;
  final bool ownCard;

  CardDetailsFetched({required this.card, required this.ownCard});
}

class LinkAdded extends CardState {
  final FieldValue field;
  LinkAdded({required this.field});
}

class Deleted extends CardState {}

class Created extends CardState {
  final String cardId;
  Created({required this.cardId});
}

class Error extends CardState {}