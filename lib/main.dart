import 'package:bizcard_app/app/app.dart';
import 'package:bizcard_app/database/local_db.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.init();
  handleDeepLink();

  Global.cameras.addAll(await availableCameras());

  runApp(
    const App()
  );

}

void handleDeepLink() async {
  try{
    Uri? initialUri;
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      print('///////////////////////////////////////////////////////////////');
      print(initialLink);
      initialUri = Uri.parse(initialLink);
      // handleLink(initialUri);
    }

    uriLinkStream.listen((Uri? uri) {
        print('///////////////////////////////////////////////////////////////');
        print(uri);
        if (uri != null && uri.toString().contains('https://bizcard-spiderlingz.web.app/i/')) {
          
        }
    });
  }catch(e){
    print("UNI links error: $e");
  }
}

