import 'package:equatable/equatable.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object> get props => [];
}

class UploadPreview extends UploadState {}

class UploadingImage extends UploadState {}

class UploadSuccess extends UploadState {}

class UploadFailed extends UploadState {}

class UploadError extends UploadState {}