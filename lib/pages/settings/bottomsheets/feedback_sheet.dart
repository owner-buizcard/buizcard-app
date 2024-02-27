import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackSheet extends StatelessWidget {
  final VoidCallback onSend;
  final TextEditingController controller;
  final ValueNotifier notifier;
  final String type;
  const   FeedbackSheet({super.key, required this.onSend, required this.controller, required this.notifier, required this.type});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          Text(type=="feature" 
            ? "Feature Request" : "Contact Support", style: GoogleFonts.inter().copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87
            )),
      
          const Gap(size: 20),
              
          Container(
            color: Colors.white,
            child: InputField(
              autofocus: true,
              controller: controller,
              maxLines: 5,
              hint: type=="feature" ? "Enter your feature request" : "Enter message",  
            ),
          ),
              
          const Gap(size: 45),
        
          ElevatedButton(
            onPressed:  (){
              FocusScope.of(context).unfocus();
              onSend();
            },
            child: const Text('Send')
          ),
        ],
      ),
    );
  }
}