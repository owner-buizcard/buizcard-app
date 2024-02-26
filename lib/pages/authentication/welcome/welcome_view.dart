import 'package:bizcard_app/constants/assets_const.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {

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
              Color(0xFFFFFFFF),
              Color(0xFFA6DCFF),
            ])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Expanded(
              child: Lottie.asset(AssetsConst.onboarding)
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
              child: Text(
                'Connect. Share. Impress. Your digital identity, effortlessly.', 
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee().copyWith(
                  color: const Color.fromARGB(255, 59, 112, 203),
                  fontSize: 16,
                  height: 2
                )),
            ),
      
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              child: Column(
                children: [

                  ElevatedButton(
                    onPressed: ()=>Navigator.pushNamed(context, Routes.signup), 
                    style: ElevatedButtonTheme.of(context).style!.copyWith(
                      padding: const MaterialStatePropertyAll(EdgeInsets.all(18)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                        )
                      ),
                      foregroundColor: const MaterialStatePropertyAll(Colors.white),
                      side: const MaterialStatePropertyAll(BorderSide(color: Color.fromARGB(255, 59, 112, 203), width: 0)),
                      backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 59, 112, 203))
                    ),
                    child: Text('Get Started', style: GoogleFonts.aBeeZee().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ))
                  ),

                  const Gap(size: 16),

                  ElevatedButton(
                    onPressed: ()=>Navigator.pushNamed(context, Routes.login), 
                    style: ElevatedButtonTheme.of(context).style!.copyWith(
                      padding: const MaterialStatePropertyAll(EdgeInsets.all(18)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                        )
                      ),
                      foregroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 59, 112, 203)),
                      side: const MaterialStatePropertyAll(BorderSide(color: Colors.white, width: 0)),
                      backgroundColor: const MaterialStatePropertyAll(Colors.white)
                    ),
                    child: Text('Already have an account? Login', style: GoogleFonts.aBeeZee().copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ))
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 26),
              child: Text(
                '© Bizcard a digital cards By Spiderlingz', 
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee().copyWith(
                  color: Colors.blue[400],
                  fontSize: 13,
                  height: 2
                )),
            ),
        
          ],
        ),
      ),
    );
  }
}