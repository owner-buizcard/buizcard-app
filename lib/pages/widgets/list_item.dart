import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Map item;
  final bool isSwitch;
  final Function(dynamic) onClick;
  const ListItem({super.key, required this.item, required this.onClick, this.isSwitch = false});

  @override
  Widget build(BuildContext context) {

    ValueNotifier<bool?> switchNotifier = ValueNotifier(item['value']);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: isSwitch
      ? ValueListenableBuilder(
        valueListenable: switchNotifier,
        builder: (_, val, __) {
          return SwitchListTile(
              value: val ?? false, 
              title: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: '${item["label"]}'.bltext(context, color:  item["color"]!=null ? 'red' : 'darker')
              ),
              onChanged: (v){
                switchNotifier.value = v;
                onClick(v);
              }
            );
        }
      )
      : ListTile(
        onTap: isSwitch ? null : ()=>onClick(item["label"]),
        leading: Icon(item["icon"], color: item["color"]),
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: '${item["label"]}'.bltext(context, color:  item["color"]!=null ? 'red' : 'darker')
        ),
      ),
    );
  }
}