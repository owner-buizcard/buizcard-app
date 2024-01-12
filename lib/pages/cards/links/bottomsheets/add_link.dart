import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';

class AddLinkSheet extends StatelessWidget {
  const AddLinkSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [  
          AppBar(
            title: const Text("Linkedin"),
            centerTitle: true,
            backgroundColor: Colors.transparent
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  MainCard(
                    child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/bizcard-web.appspot.com/o/cardbuilder%2Ficons%2Fsocial%2Flinkedin.png?alt=media&token=ff7f47d2-4397-4ce3-aa26-068e4429cf5d',
                    width: double.infinity,
                    height: 120
                  )),
                  const Gap(size: 16),
                  InputFieldWL(
                    label: 'Twitter Link', 
                    controller: TextEditingController()
                  ),
                  const Gap(size: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x268c8c8c),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.paste, size: 14),
                        Gap(size: 8),
                        Text('Paste from Clipboard')
                      ],
                    ),
                  ),
                
                  const Gap(size: 45),
                
                  ElevatedButton(
                    onPressed: ()=>{
                      Navigator.pop(context)
                    },
                    child: const Text('Add Link')
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}