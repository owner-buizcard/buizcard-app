part of 'card_bloc.dart';

@immutable
sealed class CardState {}

final class CardInitial extends CardState {}

class Loading extends CardState {}

class Success extends CardState {}

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