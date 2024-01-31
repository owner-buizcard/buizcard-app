part of 'image_bloc.dart';

sealed class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class UploadCImageEvent extends ImageEvent {
  final String cardId;
  final String croptype;
  final String path;

  const UploadCImageEvent({
    this.croptype = 'square',
    required this.cardId,
    required this.path
  });
}

class UploadImageEvent extends ImageEvent {
  final String croptype;
  final String path;
  final bool upload;


  const UploadImageEvent({
    this.croptype = 'square',
    required this.path,
    this.upload = true
  });
}