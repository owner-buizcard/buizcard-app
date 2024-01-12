import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/pages/cards/links/bottomsheets/add_link.dart';
import 'package:flutter/material.dart';

class LinkStoreViewModel extends BaseViewModel {

  addLink(BuildContext context){
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      builder: (_){
        return const AddLinkSheet();
      });
  }

  @override
  void dispose() {

  }
}