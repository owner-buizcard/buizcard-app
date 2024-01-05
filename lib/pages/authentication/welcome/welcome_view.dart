import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                boxShadow: const [BoxShadow(color: Colors.white)]
              ),
            )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: ()=>Navigator.pushNamed(context, Routes.name), 
                  child: const Text('Create Your Account')
                ),

                const Gap(size: 16),

                TextButton(
                  onPressed: ()=>Navigator.pushNamed(context, Routes.login), 
                  child: const Text('Already have an account ? Login'))
              ],
            ),
          )

        ],
      ),
    );
  }
}