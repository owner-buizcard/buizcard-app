import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/models/field.dart';
import 'package:bizcard_app/pages/cards/bloc/card_bloc.dart';
import 'package:bizcard_app/pages/cards/links/bottomsheets/add_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkStoreViewModel extends BaseViewModel {

  final GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController linkController;
  late String cardId;


  LinkStoreViewModel(String cId){
    linkController = TextEditingController();
    cardId = cId;
  }  

  addLink(BuildContext _, BuildContext context, Field field){
    FocusScope.of(_).unfocus();
    if(!formKey.currentState!.validate()){
      return;
    }
    context.read<CardBloc>().add(AddLinkEvent(linkController.trim(), field.icon, field.label, cardId));
  }

  openSheet(BuildContext context, Field field, LinkStoreViewModel viewModel){
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      builder: (_){
        return AddLinkSheet(field: field, viewModel: viewModel, onAdd: ()=> addLink(_, context, field));
      });
  }

  @override
  void dispose() {

  }
}