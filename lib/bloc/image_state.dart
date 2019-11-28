import 'package:equatable/equatable.dart';
import 'package:imgur_gallery/model/imgur_image_model.dart';
import 'package:meta/meta.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageUninitialized extends ImageState {}

class ImageEmpty extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {

  const ImageLoaded({
    @required
    this.imageUrl
  }): assert(imageUrl != null);

  final List<ImgurImageModel> imageUrl;
}

class ImageError extends ImageState {}

class UploadingImage extends ImageState {}

class ImageUploaded extends ImageState {}