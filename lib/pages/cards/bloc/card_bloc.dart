import 'package:bizcard_app/network/service/card_service.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<SaveCardEvent>(_onSaveCard);
    on<CreateCardEvent>(_onCreateCard);
    on<DeleteCardEvent>(_onDeleteCard);
    on<AddLinkEvent>(_onAddLink);
  }

  _onAddLink(AddLinkEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var found = Global.cards.value.firstWhere((element) => element.id==event.cardId);
      var data = {'fields': [...found.fields.map((e) => e.toJson()).toList(), {'icon': event.icon, 'link': event.link, 'title': event.title}]};
      var card = await CardService().saveCard(cardId: event.cardId, data: data);
      Global.updateCard(bizcard.Card.fromJson(card));
      emit(Success());
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
