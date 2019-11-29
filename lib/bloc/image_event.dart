import 'dart:io';

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
  const UploadImage(
      {@required this.image, @required this.name, @required this.desc})
      : assert(image != null),
        assert(name != null),
        assert(desc != null);

  final String image;
  final String name;
  final String desc;

  @override
  List<Object> get props => [image, name, desc];
}
