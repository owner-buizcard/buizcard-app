part of 'card_bloc.dart';

@immutable
sealed class CardEvent {}

class SaveCardEvent extends CardEvent {
  final String cardId;
  final Map data;

  SaveCardEvent(this.cardId, this.data);
}

class CreateCardEvent extends CardEvent {
  final String cardName;
  final bool isPublic;

  CreateCardEvent(this.cardName, this.isPublic);
}