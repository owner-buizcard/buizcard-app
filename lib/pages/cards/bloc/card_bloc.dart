import 'package:bizcard_app/models/field_value.dart';
import 'package:bizcard_app/models/qr_info.dart';
import 'package:bizcard_app/network/service/card_service.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../network/service/image_service.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<GetCardDetails>(_onGetCardDetails);
    on<SaveCardEvent>(_onSaveCard);
    on<CreateCardEvent>(_onCreateCard);
    on<DeleteCardEvent>(_onDeleteCard);
    on<AddLinkEvent>(_onAddLink);
    on<SaveQrEvent>(_onSaveQr);
  }

  _onGetCardDetails(GetCardDetails event, Emitter emit)async{
    emit(Loading());
    try{
      bizcard.Card card;
      bool ownCard = true;
      try{
        card = Global.cards.value.firstWhere((element) => element.id==event.cardId);
      }catch(error){
        var data = await CardService().getCard(cardId: event.cardId);
        card = bizcard.Card.fromJson(data);
        ownCard = false;
      }
      emit(CardDetailsFetched(card: card, ownCard: ownCard));
    }catch(error){
      emit(Error());
    }
  }

  _onAddLink(AddLinkEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var found = Global.cards.value.firstWhere((element) => element.id==event.cardId);
      var value = FieldValue(id: '${found.fields.length}', title: event.title, link: event.link, icon: event.icon, highlight: false);
      var data = {'fields': [...found.fields.map((e) => e.toJson()).toList(), value.toJson()]};
      var card = await CardService().saveCard(cardId: event.cardId, data: data);
      Global.updateCard(bizcard.Card.fromJson(card));
      emit(LinkAdded(field: value));
    }catch(error){
      emit(Error());
    }
  }

  _onSaveCard(SaveCardEvent event, Emitter emit)async{
    emit(Loading());
    try{
    
      var card = await CardService().saveCard(cardId: event.cardId, data: event.data);
      Global.updateCard(bizcard.Card.fromJson(card));
      emit(Success());
    }catch(error){
      emit(Error());
    }
  }

  _onSaveQr(SaveQrEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var qr = event.info;
      if(event.qrLogoPath!=null){
        var link = await ImageService().uploadImage(file: CroppedFile(event.qrLogoPath!), cardId: event.cardId);
        qr = qr.copyWith(logo: link);
      }
      var card = await CardService().saveCard(cardId: event.cardId, data: {'qr': qr.toJson()});
      Global.updateCard(bizcard.Card.fromJson(card));
      emit(Success());
    }catch(error){
      emit(Error());
    }
  }

  _onCreateCard(CreateCardEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var card = await CardService().createCard(cardName: event.cardName, isPublic: event.isPublic);
      Global.addCard(bizcard.Card.fromJson(card));
      emit(Created(cardId: card['_id']));
    }catch(error){
      emit(Error());
    }
  }

  _onDeleteCard(DeleteCardEvent event, Emitter emit)async{
    emit(Loading());
    try{
      await CardService().deleteCard(event.cardId);
      Global.removeCard(event.cardId);
      emit(Deleted());
    }catch(error){
      emit(Error());
    }
  }


}
