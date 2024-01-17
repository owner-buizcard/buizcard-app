part of 'card_bloc.dart';

@immutable
sealed class CardEvent {}

class SaveCardEvent extends CardEvent {
  final String cardId;
  final Map data;

  SaveCardEvent(this.cardId, this.data);
}

class DeleteCardEvent extends CardEvent {
  final String cardId;

  DeleteCardEvent(this.cardId);
}

class CreateCardEvent extends CardEvent {
  final String cardName;
  final bool isPublic;

  CreateCardEvent(this.cardName, this.isPublic);
}

class AddLinkEvent extends CardEvent {
  final String link;
  final String icon;
  final String title;
  final String cardId;

  AddLinkEvent(this.link, this.icon, this.title, this.cardId);
}