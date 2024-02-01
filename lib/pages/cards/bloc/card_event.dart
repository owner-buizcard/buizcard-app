part of 'card_bloc.dart';

@immutable
sealed class CardEvent {}

class GetCardDetails extends CardEvent {
  final String cardId;

  GetCardDetails(this.cardId);
}

class GetCardAnalyticsEvent extends CardEvent {
  final String cardId;

  GetCardAnalyticsEvent(this.cardId);
}

class SaveCardEvent extends CardEvent {
  final String cardId;
  final Map data;

  SaveCardEvent(this.cardId, this.data);
}

class SaveQrEvent extends CardEvent {
  final String cardId;
  final QrInfo info;
  final String? qrLogoPath;

  SaveQrEvent(this.cardId, this.info, {this.qrLogoPath});
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