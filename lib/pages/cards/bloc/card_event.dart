part of 'card_bloc.dart';

@immutable
sealed class CardEvent {}

class SaveCardEvent extends CardEvent {
  final String cardId;
  final Map data;

  SaveCardEvent(this.cardId, this.data);
}