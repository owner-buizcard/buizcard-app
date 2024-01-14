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
  }

  _onSaveCard(SaveCardEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var card = await CardService().saveCard(cardId: event.cardId, data: event.data);
      Global.updateCard(bizcard.Card.fromJson(card));
      emit(Success());
    }catch(error){
      print(error);
      emit(Error());
    }
  }

  _onCreateCard(CreateCardEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var card = await CardService().createCard(cardName: event.cardName, isPublic: event.isPublic);
      emit(Created(cardId: card['_id']));
    }catch(error){
      emit(Error());
    }
  }
}
