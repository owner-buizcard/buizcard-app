import 'package:bizcard_app/constants/assets_const.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

final TextStyle _textStyle = GoogleFonts.aBeeZee().copyWith(
  color: const Color.fromARGB(255, 59, 112, 203),
  fontSize: 16,
  height: 2,
);

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  ElevatedButton _buildElevatedButton({
    required VoidCallback onPressed,
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        side: const BorderSide(color: Colors.white, width: 0),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(
        label,
        style: GoogleFonts.aBeeZee().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const BoxDecoration gradientDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFFA6DCFF),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: gradientDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Lottie.asset(AssetsConst.onboarding)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
              child: Text(
                'Connect. Share. Impress. Your digital identity, effortlessly.',
                textAlign: TextAlign.center,
                style: _textStyle,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              child: Column(
                children: [
                  _buildElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, Routes.signup),
                    label: 'Get Started',
                    backgroundColor: const Color.fromARGB(255, 59, 112, 203),
                    foregroundColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  _buildElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, Routes.login),
                    label: 'Already have an account? Login',
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 59, 112, 203),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 26),
              child: Text(
                '© Buizcard a digital cards By Spiderlingz',
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee().copyWith(
                  color: Colors.blue[400],
                  fontSize: 13,
                  height: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
