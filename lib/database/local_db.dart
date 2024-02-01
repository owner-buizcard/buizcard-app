import 'package:hive_flutter/hive_flutter.dart';

class LocalDB {

  static init()async{
    await Hive.initFlutter();
    await Hive.openBox('credentials');
    await Hive.openBox('config');
  }

  static Future clearDB()async{
    var box = Hive.box('credentials');
    await box.clear();
  }

  static launchDone(){
    var box = Hive.box('config');
    box.put('launch', false);
  }

  static showGuide(){
    var box = Hive.box('config');
    return box.get('launch') ?? true;
  }

  static saveToken(token){
    var box = Hive.box('credentials');
    box.put('accessToken', token['accessToken']);
    box.put('refreshToken', token['refreshToken']);
  }

  static getAccessToken(){
    var box = Hive.box('credentials');
    return box.get('accessToken');
  }

  static getRefreshToken(){
    var box = Hive.box('credentials');
    return box.get('refreshToken');
  }


}