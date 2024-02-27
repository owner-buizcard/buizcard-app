part of 'image_bloc.dart';

sealed class ImageState extends Equatable {
  const ImageState();
  
  @override
  List<Object> get props => [];
}

final class ImageInitial extends ImageState {}

final class UploadedSuccess extends ImageState {
  final String link;
  final String type;

  const UploadedSuccess({
    required this.link,
    required this.type
  });
}

final class PickedSuccess extends ImageState {
  final String path;

  const PickedSuccess({
    required this.path
  });
}

final class Failure extends ImageState {}

class Uploading extends ImageState {}

class Removed extends ImageState {}