import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/database/local_db.dart';
import 'package:bizcard_app/network/service/main_service.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends BaseViewModel {
  
  
  init(BuildContext context)async{
    var accessToken = LocalDB.getAccessToken();

    if(accessToken==null){
      Future.delayed(const Duration(seconds: 5), ()=>Navigator.pushNamed(context, Routes.welcome));
      return;
    }

    MainService().fetchMainData(loader: false).then(
      (value){
        Global.init(value);
        Navigator.pushNamed(context, Routes.home);
      });
  }
  
  @override
  void dispose() {
    
  }

}