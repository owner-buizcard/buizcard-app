import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/card_options_sheet.dart';
import 'package:bizcard_app/pages/dashboard/bottomsheets/contact_options_sheet.dart';
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

  DashboardViewModel(){
    controller = PageController();
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
  
  openCardOptions(BuildContext context){
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (_){
        return const CardOptionsSheet();
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


  @override
  void dispose() {
  
  }

}