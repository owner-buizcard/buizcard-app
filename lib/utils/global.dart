import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bizcard_app/models/user.dart';
import 'package:flutter/material.dart';

class Global {
  
  static User? user;
  static ValueNotifier<List<bizcard.Card>> cards = ValueNotifier([]);
  static List contacts = [];
  static List fieldTypes = [];

  static init(data){
    user = User.fromJson(data['user']);
    cards.value = (data['cards'] as List).map((e) => bizcard.Card.fromJson(e)).toList();
    contacts = data['contacts'];
    fieldTypes = data['config']['fieldTypes'];
  }

  static addCard(bizcard.Card card){
    cards.value.add(card);
  }

  static updateCard(bizcard.Card card){
    int index = cards.value.indexWhere((element) => element.id == card.id);
    if (index != -1) {
      cards.value[index] = card;
    }
  }

  static removeCard(String cardId){
    cards.value.removeWhere((element) => element.id==cardId);
  }

}