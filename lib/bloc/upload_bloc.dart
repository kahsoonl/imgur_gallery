import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:imgur_gallery/bloc/bloc.dart';
import 'package:imgur_gallery/repository/repository.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {

  UploadBloc({@required this.imageRepository}): assert(imageRepository!=null);

  final ImageRepository imageRepository;

  @override
  UploadState get initialState => UploadPreview();

  @override
  Stream<UploadState> mapEventToState(UploadEvent event) async* {
    if(event is UploadImage) {
      yield UploadingImage();
      try {
        final bool successUpload = await imageRepository.uploadImage(event.image, event.name);
        if(successUpload) {
          yield UploadSuccess();
        } else {
          yield UploadFailed();
        }
      } catch (_) {
        yield UploadError();
      }
    }
  }
}