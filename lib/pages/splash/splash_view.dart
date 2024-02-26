import 'package:bizcard_app/constants/assets_const.dart';
import 'package:bizcard_app/pages/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    SplashViewModel().init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF10A0FF),
              Color(0xFF2A5298)
            ])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsConst.logo, width: 100),
            Text('BIZCARD', style: GoogleFonts.lalezar(
              fontSize: 44,
              color: Colors.white,
            ))
          ],
        ),
      ),
    );
  }
}
