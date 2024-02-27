import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bizcard_app/models/field.dart';
import 'package:bizcard_app/models/integration.dart';
import 'package:bizcard_app/models/user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class Global {
  static late User? user;
  static ValueNotifier<List<bizcard.Card>> cards = ValueNotifier([]);
  static List<Contact> contacts = [];
  static List<Field> fieldTypes = [];
  static List<Integration> integrations = [];
  static Map<String, List<Field>> groupedFields = {};

  static final List<CameraDescription> cameras = [];
  static late String openAiKey; // Use late initialization

  static init(data) {
    try {
      user = User.fromJson(data['user']);
      cards.value = (data['cards'] as List).map((e) => bizcard.Card.fromJson(e)).toList();
      contacts = (data['contacts'] as List).map((e) => Contact.fromJson(e)).toList();

      fieldTypes = (data['config']['fieldTypes'] as List).map((e) => Field.fromJson(e)).toList();
      var configs = data['config']['configs'] as List;

      for (var item in fieldTypes) {
        String category = item.category;
        groupedFields[category] = groupedFields[category] ?? [];
        groupedFields[category]!.add(item);
      }

      for (var config in configs) {
        if (config["key"] == "OPEN_AI_KEY") {
          openAiKey = config["value"];
        }else if(config["key"] == "Integrations") {
          integrations = (config["value"] as List).map((e) => Integration.fromJson(e)).toList();
        }
      }

    } catch (e) {
      print('Error initializing Global: $e');
    }
  }

  static addCard(bizcard.Card card) {
    cards.value.add(card);
    cards.notifyListeners();
  }

  static updateCard(bizcard.Card card) {
    int index = cards.value.indexWhere((element) => element.id == card.id);
    if (index != -1) {
      cards.value[index] = card;
    }
    cards.notifyListeners();
  }

  static removeCard(String cardId) {
    cards.value.removeWhere((element) => element.id == cardId);
    cards.notifyListeners();
  }

  static Color hexToColor(String hexString) {
    try{
      return Color(int.parse(hexString.substring(1, 7), radix: 16) + 0xFF000000);
    }catch(e){
      return Colors.black;
    }
  }
}
