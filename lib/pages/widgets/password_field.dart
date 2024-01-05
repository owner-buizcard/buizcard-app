import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/strength_indicator.dart';
import 'package:bizcard_app/utils/password_strength.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final bool showIndicator;
  const PasswordField({
    super.key, required this.label, this.prefixIcon, this.showIndicator = true});

  @override
  Widget build(BuildContext context) {

    final ValueNotifier<bool> notifier = ValueNotifier(true);
    final ValueNotifier<int> strengthNotifier = ValueNotifier<int>(0);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const Gap(size: 10),
        ValueListenableBuilder<bool>(
          valueListenable: notifier,
          builder: (_, value, ___){
            return TextFormField(
              obscureText: value,
              onChanged: (value) {
                strengthNotifier.value = strengthIndicator(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(prefixIcon),
                suffixIcon: IconButton(
                  onPressed: () => notifier.value=!value, 
                  icon: Icon(
                    value ? AntIcons.eyeFilled: AntIcons.eyeOutlined))
              ),
            );
          },
        ),

        Visibility(
          visible: showIndicator,
          child: ValueListenableBuilder<int>(
          valueListenable: strengthNotifier,
          builder: (_, level, ___) {
            return Visibility(
              visible: showIndicator,
              child: StrengthIndicator(level),
            );
          },
        ))
      ],
    );
  }
}