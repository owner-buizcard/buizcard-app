import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:flutter/material.dart';

class ConfirmSheet extends StatelessWidget {
  final VoidCallback onDelete;
  final TextEditingController controller;
  final ValueNotifier notifier;
  const ConfirmSheet({super.key, required this.onDelete, required this.controller, required this.notifier});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        children: [
          Text(
            'Delete Account', style: Theme.of(context).textTheme.titleMedium),
      
          const Gap(size: 16),
          Text(
            'Are you sure, you want to delete your account? Type Confirm to delete your account.', style: Theme.of(context).textTheme.labelSmall),
        
          const Gap(size: 16),
              
          InputField(
            controller: controller,
            hint: 'Confirm',  
            onChanged: (v){
              notifier.value = v=="Confirm";
            },
          ),
              
          const Gap(size: 45),
        
          ValueListenableBuilder(
            valueListenable: notifier,
            builder: (_, val, __) {
              return ElevatedButton(
                onPressed: val ? (){
                  FocusScope.of(context).unfocus();
                  onDelete();
                } : null,
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  side: const MaterialStatePropertyAll(BorderSide.none),
                  backgroundColor: MaterialStatePropertyAll(val ? Colors.red : Colors.grey ),
                ),
                child: const Text('Delete Account')
              );
            }
          ),
        ],
      ),
    );
  }
}