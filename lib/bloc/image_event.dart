
import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
}

class FetchImage extends ImageEvent {
  @override
  List<Object> get props => [];
}
