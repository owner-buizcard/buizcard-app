import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:flutter/material.dart';

class EditUserNameViewModel extends BaseViewModel {
  late TextEditingController controller;

  EditUserNameViewModel(){
    controller = TextEditingController();
  }
  
  @override
  void dispose() {

  }
}