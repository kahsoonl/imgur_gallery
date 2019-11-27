import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
}

class FetchImage extends ImageEvent {

  @override
  List<Object> get props => [];
}

class UploadImage extends ImageEvent {

  const UploadImage({
    @required
    this.image
  }) : assert(image != null);

  final String image;

  @override
  List<Object> get props => null;
}