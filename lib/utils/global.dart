import 'package:bizcard_app/models/user.dart';

class Global {
  
  static User? user;
  static List cards = [];
  static List contacts = [];
  static List fieldTypes = [];

  static init(data){
    user = User.fromJson(data['user']);
    cards = data['cards'];
    contacts = data['contacts'];
    fieldTypes = data['config']['fieldTypes'];
  }

}