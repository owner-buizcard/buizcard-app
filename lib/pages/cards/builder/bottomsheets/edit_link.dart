import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/constants/colors_const.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditLinkSheet extends StatelessWidget {
  const EditLinkSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        children: [  
          AppBar(
            title: const Text("Linkedin"),
            centerTitle: true,
            leading: IconButton(onPressed: ()=>Navigator.pop(context), 
              icon: const Icon(Icons.close)),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: ()=>Navigator.pop(context), 
                icon: const Icon(AntIcons.deleteOutlined, color: Colors.red)
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                
                MainCard(
                  child: Column(
                    children: [
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/bizcard-web.appspot.com/o/cardbuilder%2Ficons%2Fsocial%2Flinkedin.png?alt=media&token=ff7f47d2-4397-4ce3-aa26-068e4429cf5d',
                        width: double.infinity,
                        height: 100
                      ),
          
                      Text('@agamagilan', style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w700
                      ))
                    ],
                  )
                ),
                const Gap(size: 16),
                InputFieldWL(
                  label: 'Link', 
                  controller: TextEditingController()
                ),
                const Gap(size: 12),
                InputFieldWL(
                  label: 'Title', 
                  controller: TextEditingController()
                ),
                const Gap(size: 16),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 46,
                      height: 36,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(value: true, onChanged: (v){})
                      ),
                    ),
                    const Gap(size: 8),
                    Text('Highlight', style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorsConst.primary
                      ))
                  ],
                ),
          
                const Gap(size: 24),
              
                ElevatedButton(
                  onPressed: ()=>{
                    Navigator.pop(context)
                  },
                  child: const Text('Save Link')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}