import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Contact', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 28
            )),
          Text(
            'You can get a lead via text or call', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color(0xFFB0B0B0)
            )),

          const Gap(size: 20),
          
          InputField(
            controller: TextEditingController(),
            label: 'Phone Number'  
          ),

          const Gap(size: 32),

          ElevatedButton(
            onPressed: ()=>Navigator.pushNamed(context, Routes.create),
            child: const Text('Continue')
          ),

          const Gap(size: 24),

          TextButton(
            onPressed: ()=>Navigator.pushNamed(context, Routes.create), 
            child: const Text('Skip'))
        ],
      ),
    );
  }
}