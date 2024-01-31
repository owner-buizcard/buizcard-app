import 'package:bizcard_app/constants/constants.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';

import '../../utils/global.dart';

class ColorPickerFieldWL extends StatelessWidget {
  final String label;
  final String selected;
  final Function(String) onClick;
  const ColorPickerFieldWL({
    super.key, 
    required this.label,
    required this.selected,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.btext(context, color: 'dark'),
        const Gap(size: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20
          ), 
          itemCount: Constants.pickerColors.length,
          itemBuilder: (_, index){
            String item = Constants.pickerColors[index];
            Color color = Global.hexToColor(item);
              return InkWell(
                onTap: ()=>onClick(item),
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  backgroundColor: selected == item 
                    ? color 
                    : Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: selected == item 
                        ? Colors.white 
                        : Colors.transparent, width: 3),
                      borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
              );
          }
        )
      ],
    );
  }
}