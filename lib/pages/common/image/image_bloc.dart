import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors_const.dart';
import '../../../network/service/image_service.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<UploadCImageEvent>(_onUploadCImageEvent);
    on<UploadImageEvent>(_onUploadImageEvent);
  }

  _onUploadImageEvent(UploadImageEvent event, Emitter emit)async{
    emit(Uploading());
    try{
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if(image==null){
        emit(Failure());
      }

      var aspectRatio = event.croptype=='square' ? [CropAspectRatioPreset.square] : [CropAspectRatioPreset.ratio16x9];

      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: ColorsConst.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false)
        ],
      );

      if(cropped!=null){
        var link = await ImageService().uploadImage(file: cropped, cardId: event.path);
        emit(UploadedSuccess(link: link, type: event.path));
      }else{
        emit(Failure());
      }

    }catch(error){
      emit(Failure());
    }
  }

  _onUploadCImageEvent(UploadCImageEvent event, Emitter emit)async{
    emit(Uploading());
    try{

      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if(image==null){
        emit(Failure());
      }

      var aspectRatio = event.croptype=='square' ? [CropAspectRatioPreset.square] : [CropAspectRatioPreset.ratio16x9];

      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: ColorsConst.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false)
        ],
      );

      if(cropped!=null){
        var link = await ImageService().uploadImage(file: cropped, cardId: event.cardId);
        emit(UploadedSuccess(link: link, type: event.path));
      }else{
        emit(Failure());
      }
    }catch(error){
      emit(Failure());
    }
  }
}
