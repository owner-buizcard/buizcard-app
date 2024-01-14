import 'package:bizcard_app/app/app.dart';
import 'package:bizcard_app/database/local_db.dart';
import 'package:flutter/material.dart';


void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.init();

  runApp(
    const App()
  );
}
