import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NameView extends StatefulWidget {
  const NameView({super.key});

  @override
  State<NameView> createState() => _NameViewState();
}

class _NameViewState extends State<NameView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Let’s get started', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 28
            )),
          Text(
            'Hello, Introduce yourself', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color(0xFFB0B0B0)
            )),

          const Gap(size: 20),
          
          const InputField(
            label: 'Enter your name'  
          ),

          const Gap(size: 32),

          ElevatedButton(
            onPressed: (){}, 
            child: const Text('Continue')
          ),
        ],
      ),
    );
  }
}