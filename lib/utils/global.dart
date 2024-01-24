import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bizcard_app/models/field.dart';
import 'package:bizcard_app/models/user.dart';
import 'package:camera/camera.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class Global {
  
  static User? user;
  static ValueNotifier<List<bizcard.Card>> cards = ValueNotifier([]);
  static List contacts = [];
  static List<Field> fieldTypes = [];
  static Map<String, List<Field>> groupedFields = {};

  static final List<CameraDescription> cameras = [];

  static String openAiKey = "";


  static init(data){
    user = User.fromJson(data['user']);
    cards.value = (data['cards'] as List).map((e) => bizcard.Card.fromJson(e)).toList();
    contacts = (data['contacts'] as List).map((e) => Contact.fromJson(e)).toList();
    fieldTypes = (data['config']['fieldTypes'] as List).map((e) => Field.fromJson(e)).toList();
    var configs = data['config']['configs'] as List;

    configs.map((e){
      if(e["key"]=="OPEN_AI_KEY"){
        openAiKey = e["value"];
        OpenAI.apiKey = openAiKey;
      }
    });    

    for (var item in fieldTypes) {
      String category = item.category;
      groupedFields[category] = groupedFields[category] ?? [];
      groupedFields[category]!.add(item);
    }
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