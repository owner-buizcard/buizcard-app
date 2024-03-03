import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/network/service/user_service.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bizcard_app/utils/toast.dart';
import 'package:flutter/material.dart';

import '../../../utils/debouncer.dart';

class EditUsernameView extends StatefulWidget {
  const EditUsernameView({super.key});

  @override
  State<EditUsernameView> createState() => _EditUsernameViewState();
}

class _EditUsernameViewState extends State<EditUsernameView> {
  final _debouncer = Debouncer(milliseconds: 500);
  
  late TextEditingController controller;
  String link = Global.user!.personalizedLink ?? "";
  String? state;

  @override
  void initState() {
    controller = TextEditingController(text: link);
    super.initState();
  }

  handleTextChange(value){
    setState(()=>link=value);
    _debouncer.run(() {
      setState(() {
        state="loading";
      });
      UserService().checkLinkAvailable(value).then(
        (value) => setState(()=>state=(value==true) ? "success": "error"));
    });
  }

  saveLink(){
    FocusScope.of(context).unfocus();
    setState(() { state=null;});
    Global.user =  Global.user!.copyWith(personalizedLink: link);
    UserService().updatePersonalizedLink(link);
    toast("Updated successfully!", success: true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Link"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
        
            InputFieldWL(
              label: "Personalized Link", 
              prefixText: "bizcard.co/",
              hint: "xyzedjd",
              controller: controller,
              onChanged: (e)=>handleTextChange(e),
            ),
        
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('bizcard.co/$link', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: state == "loading" 
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : state == "success"
                    ? const Icon(AntIcons.checkCircleOutlined, color: Colors.green)
                    : state == "error"
                    ? const Icon(AntIcons.closeCircleOutlined, color: Colors.red)
                    : Container(),
                  )
                ],
              ),
            ),

            const Gap(size: 24),

            SizedBox(
              width: 200,
              child: Visibility(
                visible: state=="success",
                child: ElevatedButton(
                  onPressed: ()=> saveLink(), 
                  child: const Text("Save")),
              ),
            )
        
          ],
        ),
      ),
    );
  }
}