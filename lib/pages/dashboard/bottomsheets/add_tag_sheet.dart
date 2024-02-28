import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';

import '../../widgets/gap.dart';
import '../../widgets/input_field.dart';

class AddTagSheet extends StatefulWidget {
  final Function onSave;
  final String contactId;
  const AddTagSheet({super.key, required this.contactId, required this.onSave});

  @override
  State<AddTagSheet> createState() => _AddTagSheetState();
}

class _AddTagSheetState extends State<AddTagSheet> {

  List tags = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    tags = Global.contacts.value.firstWhere((element) => element.id==widget.contactId).tags;
    super.initState();
  }

  void _addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag) && tags.length<4) {
      setState(() {
        tags = [...tags, tag];
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 104),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            children: [
              InkWell(onTap: ()=>Navigator.pop(context), child: const Icon(AntIcons.arrowLeftOutlined)),
              const Gap(size: 16),
              Expanded(child: Text('Add Tag', style: Theme.of(context).textTheme.titleSmall,)),
              TextButton(
              onPressed: (){
                FocusScope.of(context).unfocus();
                widget.onSave(tags);
              },
              child: const Text("Save")),
            ],
          ),

          Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: tags.map((tag) {
              return Chip(
                label: '$tag'.btext(context, color: 'darker'),
                color: const MaterialStatePropertyAll(Color(0xFFE9E9E9)),
                side: BorderSide(color: Colors.grey[300]!),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                onDeleted: () {
                  setState(() {
                    tags.remove(tag);
                  });
                },
              );
            }).toList(),
          ),
          const Gap(size: 16),
          InputField( 
            autofocus: true,
            controller: controller,
            onFieldSubmitted: _addTag,
            maxLines: 3,
            suffixIcon: Icons.add,
            onSuffixIconClick: ()=>_addTag(controller.trim())
          ),
          const Gap(size: 4),
          Text('Note: Maximum three tags only can add.', style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.grey
          ))
        ],
      ),
    );
  }
}