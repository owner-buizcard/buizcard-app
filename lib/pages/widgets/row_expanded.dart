import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';

class RowExpanded extends StatelessWidget {
  final List<Widget> children;
  final double? gap;

  const RowExpanded({Key? key, required this.children, this.gap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];

    for (int i = 0; i < children.length; i++) {
      if (gap != null && i % 2 != 0) {
        rowChildren.add(Gap(size: gap!));
      }

      rowChildren.add(Expanded(child: children[i]));
    }

    return Row(
      children: rowChildren,
    );
  }
}
