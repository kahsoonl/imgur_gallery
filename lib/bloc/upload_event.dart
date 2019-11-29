import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();
}

class UploadImage extends UploadEvent {
  const UploadImage(
      {@required this.image, @required this.name})
      : assert(image != null),
        assert(name != null);

  final String image;
  final String name;

  @override
  List<Object> get props => [image, name];
}