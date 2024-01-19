import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/pages/cards/bloc/card_bloc.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/card_options_sheet.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/contact_options_sheet.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/create_card_sheet.dart';
import 'package:bizcard_app/pages/dashboard/cubit/bottomnav_cubit.dart';
import 'package:bizcard_app/pages/dashboard/fragments/my_cards_fragment.dart';
import 'package:bizcard_app/pages/dashboard/fragments/my_contacts_fragment.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardViewModel extends BaseViewModel {

  final List bottomNavItems = [
    {
      'icon': AntIcons.idcardOutlined,
      'label': 'Cards'
    },
    {
      'icon': Icons.contacts_outlined,
      'label': 'Contacts'
    },
    {
      'icon': Icons.qr_code_scanner_outlined,
      'label': 'Scan'
    },
    {
      'icon': Icons.settings_outlined,
      'label': 'Settings'
    }
  ];

  late PageController controller;
  late TextEditingController cardnameController;

  final GlobalKey<FormState> formKey = GlobalKey();

  DashboardViewModel(){
    controller = PageController();
    cardnameController = TextEditingController();
  }

  getPages(DashboardViewModel viewModel){
    return [
      MyCardsFragment(viewModel: viewModel),
      MyContactsFragment(viewModel: viewModel)
    ];
  }

  onMove(index, BuildContext context){
    if(index<2){
      controller.jumpToPage(index);
      context.read<HomePageCubit>().onPageChange(index);
    }else {
      Navigator.pushNamed(context, index==2 ? Routes.scan : Routes.settings);
    }
  }
  
  openCardOptions(String cardId, BuildContext context){
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (_){
        return CardOptionsSheet(
          onClick: (v){
            Navigator.pop(context);
            if(v=='Edit'){
              Navigator.of(context).pushNamed(Routes.cardBuilder, arguments: cardId);
            }else if(v=='Delete'){
              context.read<CardBloc>().add(DeleteCardEvent(cardId));
            }
          },
        );
    });
  }

  openContactOptions(BuildContext context){
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (_){
        return const ContactOptionsSheet();
    });
  }

  openCreateSheet(BuildContext context, viewModel){
   showModalBottomSheet(
      context: context, 
      backgroundColor: Colors.white,
      builder: (_){
        return CreateCardSheet(
          viewModel: viewModel,
          onCreate: ()=>createCard(context)
        );
    });
  }

  createCard(BuildContext context){
    FocusScope.of(context).unfocus();
    if(!formKey.currentState!.validate()){
      return;
    }
    Navigator.pop(context);
    context.read<CardBloc>().add(
      CreateCardEvent(cardnameController.trim(), false));
  }

  @override
  void dispose() {
  
  }

}