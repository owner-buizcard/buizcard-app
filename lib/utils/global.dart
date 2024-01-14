import 'package:bizcard_app/models/card.dart';
import 'package:bizcard_app/models/user.dart';

class Global {
  
  static User? user;
  static List<Card> cards = [];
  static List contacts = [];
  static List fieldTypes = [];

  static init(data){
    user = User.fromJson(data['user']);
    cards = (data['cards'] as List).map((e) => Card.fromJson(e)).toList();
    contacts = data['contacts'];
    fieldTypes = data['config']['fieldTypes'];
  }

  static addCard(Card card){
    cards.add(card);
  }

  static updateCard(Card card){
    int index = cards.indexWhere((element) => element.id == card.id);
    if (index != -1) {
      cards[index] = card;
    }
  }

  static removeCard(String cardId){
    cards.removeWhere((element) => element.id==cardId);
  }

}