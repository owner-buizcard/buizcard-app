import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/pages/account/bloc/account_bloc.dart';
import 'package:bizcard_app/pages/settings/bottomsheets/save_whatsapp_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/global.dart';

class IntegrationViewModel extends BaseViewModel {

  late TextEditingController numberController;
  late ValueNotifier<bool> enableWhatsapp;
  final GlobalKey<FormState> formKey = GlobalKey();

  IntegrationViewModel(){
    var user = Global.user;
    numberController = TextEditingController(text: user!.whatsappNumber??'');
    enableWhatsapp = ValueNotifier(user.enableWhatsapp);
  }
  
  openWhatsappSheet(BuildContext context, viewModel){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (_) {
          return SaveWhatsappSheet(
              viewModel: viewModel, onSave: (){
                if (!formKey.currentState!.validate()) {
                  return;
                }
                Navigator.pop(context);
                context.read<AccountBloc>().add(
                  UpdateUserEvent(data: {
                    'whatsappNumber': numberController.trim(),
                    'enableWhatsapp': enableWhatsapp.value
                  })
                );
              });
        });
  }

  @override
  void dispose() {

  }
}