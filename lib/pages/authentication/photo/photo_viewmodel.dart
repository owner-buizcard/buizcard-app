import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/image/image_bloc.dart';

class PhotoViewModel extends BaseViewModel {

  late ValueNotifier<String?> picture;

  PhotoViewModel(){
    picture = ValueNotifier(null);
  }

  pickImage(BuildContext context, String type){
    context.read<ImageBloc>().add(
      UploadImageEvent(path: type));
  }
  
  @override
  void dispose() {}

}