import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bizcard_app/constants/assets_const.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../common/open_ai/ai_bloc.dart';

class ExtracterView extends StatefulWidget {
  final String text;
  const ExtracterView({super.key, required this.text});

  @override
  State<ExtracterView> createState() => _ExtracterViewState();
}

class _ExtracterViewState extends State<ExtracterView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<AiBloc, AiState>(
        listener: (context, state) {
          if(state is ExtractedContact){
            Navigator.pushNamed(context, Routes.createContact, arguments: state.contact);
          }else if(state is Failure){
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Lottie.asset(AssetsConst.relaxing),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.labelSmall!,
                  child: AnimatedTextKit(animatedTexts: [
                    TypewriterAnimatedText(
                        'Transforming Paper to Pixels: Your Visiting Card, Reinvented!',
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 100)),
                    TypewriterAnimatedText(
                        'Empower Your Network: Scan, Save, and Share in a Snap!',
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 100)),
                    TypewriterAnimatedText(
                        'From Handshake to Hard Drive: Your Visiting Card in the Digital Age!',
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 100)),
                  ]),
                ),
                const Spacer(),
                const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(strokeWidth: 2)),
                const Gap(size: 32),
                const Text('Preparing contact...'),
                const Gap(size: 64)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
