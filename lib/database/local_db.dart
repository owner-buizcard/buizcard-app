import 'package:hive_flutter/hive_flutter.dart';

class LocalDB {

  static init()async{
    await Hive.initFlutter();
    await Hive.openBox('credentials');
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