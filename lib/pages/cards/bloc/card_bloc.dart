import 'package:bizcard_app/network/service/card_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<SaveCardEvent>(_onSaveCard);
  }

  _onSaveCard(SaveCardEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var res = await CardService().saveCard(cardId: event.cardId, data: event.data);
      print(res);
      emit(Success());
    }catch(error){
      emit(Error());
    }
  }
}
