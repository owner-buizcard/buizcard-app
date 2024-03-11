import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/constants/colors_const.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/models/field_value.dart';
import 'package:bizcard_app/pages/cards/builder/card_builder_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditLinkSheet extends StatefulWidget {
  final FieldValue value;
  final CardBuilderViewModel viewModel;
  const EditLinkSheet({super.key, required this.value, required this.viewModel});

  @override
  State<EditLinkSheet> createState() => _EditLinkSheetState();
}

class _EditLinkSheetState extends State<EditLinkSheet> {
  late TextEditingController linkController;
  late TextEditingController titleController;
  late TextEditingController descController;
  late ValueNotifier<bool> switchNotifier;

  @override
  void initState() {
    linkController = TextEditingController(text: widget.value.link);
    titleController = TextEditingController(text: widget.value.title);
    descController = TextEditingController(text: widget.value.desc);
    switchNotifier = ValueNotifier(widget.value.highlight);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Form(
      key: widget.viewModel.linkKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView(
          children: [  
            AppBar(
              leadingWidth: 30,
              title: Text(widget.value.title),
              centerTitle: true,
              leading: IconButton(onPressed: ()=>Navigator.pop(context), 
                icon: const Icon(Icons.close)),
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: ()=>widget.viewModel.removeLink(context), 
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/bizcard-web.appspot.com/o/${widget.value.icon}',
                          width: double.infinity,
                          height: 100
                        ),
            
                        Visibility(
                          visible: widget.viewModel.linkTitleController.text.isNotEmpty,
                          child: Text(widget.viewModel.linkTitleController.text, style: Theme.of(context).textTheme.labelLarge))
                      ],
                    )
                  ),
                  const Gap(size: 16),
                  InputFieldWL(
                    label: 'Link', 
                    isRequired: true,
                    controller: linkController
                  ),
                  const Gap(size: 12),
                  InputFieldWL(
                    label: 'Title', 
                    isRequired: true,
                    controller: titleController
                  ),
                  const Gap(size: 16),
            
                  ValueListenableBuilder(
                    valueListenable: switchNotifier,
                    builder: (_, value, __) {
                      return Column(
                        children: [
                          Visibility(
                            visible: value,
                            child: InputFieldWL(
                            label: 'Description', 
                            isRequired: value && true,
                            controller: descController
                          )),
      
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 46,
                                height: 36,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Switch(value: value, onChanged: (v){
                                    switchNotifier.value = v;
                                  })
                                ),
                              ),
                              const Gap(size: 8),
                              Text('Highlight', style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorsConst.primary
                                ))
                            ],
                          )
                        ],
                      );
                    }
                  ),
            
                  const Gap(size: 24),
                
                  ElevatedButton(
                    onPressed: ()=>widget.viewModel.editLink(context, FieldValue(
                      id: widget.value.id, 
                      title: titleController.trim(), 
                      link: linkController.trim(), 
                      icon: widget.value.icon, 
                      highlight: switchNotifier.value
                    )),
                    child: const Text('Save Link')
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}