import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Company Info', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 28
            )),
          Text(
            'Tell us your company details', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color(0xFFB0B0B0)
            )),

          const Gap(size: 20),
          
          const InputField(
            label: 'Job title'  
          ),

          const Gap(size: 10),

          const InputField(
            label: 'Company Name'  
          ),

          const Gap(size: 32),

          ElevatedButton(
            onPressed: ()=>Navigator.pushNamed(context, Routes.contactInfo),
            child: const Text('Continue')
          ),

          const Gap(size: 24),

          TextButton(
            onPressed: ()=>Navigator.pushNamed(context, Routes.contactInfo),
            child: const Text('Skip'))
        ],
      ),
    );
  }
}