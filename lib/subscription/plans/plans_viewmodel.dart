import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:flutter/material.dart';

class PlansViewModel extends BaseViewModel {
  
  late ValueNotifier<int> selected;

  PlansViewModel(){
    selected = ValueNotifier(0);
  }

  @override
  void dispose() {

  }
}