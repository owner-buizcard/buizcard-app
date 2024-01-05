import 'package:bizcard_app/utils/password_strength.dart';
import 'package:flutter/widgets.dart';

class StrengthIndicator extends StatelessWidget {
  final int level;
  const StrengthIndicator(this.level, {super.key});

  @override
  Widget build(BuildContext context) {

    var strength = strengthColor(level);

    return Container(
    margin: const EdgeInsets.only(top: 8.0),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 85,
              height: 8,
              decoration: BoxDecoration(
                color: Color(int.parse(strength['color'])),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              strength['label'],
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
  }
}