import 'package:bizcard_app/app/app.dart';
import 'package:bizcard_app/database/local_db.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.init();

  Global.cameras.addAll(await availableCameras());

  runApp(
    const App()
  );
}
