import 'package:bizcard_app/constants/assets_const.dart';
import 'package:flutter/material.dart';

class CallbackView extends StatefulWidget {
  const CallbackView({super.key});

  @override
  State<CallbackView> createState() => _CallbackViewState();
}

class _CallbackViewState extends State<CallbackView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsConst.thumbp),
            const Text('Authenticating ...')
          ],
        ),
      ),
    );
  }
}