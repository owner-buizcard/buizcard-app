import 'package:flutter/widgets.dart';

class Gap extends StatelessWidget {
  final double size;
  const Gap({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
    );
  }
}