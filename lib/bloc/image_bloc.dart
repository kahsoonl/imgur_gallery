import 'package:imgur_gallery/bloc/bloc.dart';
import 'package:imgur_gallery/model/imgur_image_model.dart';
import 'package:imgur_gallery/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {

  ImageBloc({@required this.imageRepository}) : assert(imageRepository != null);

  final ImageRepository imageRepository;

  @override
  ImageState get initialState => ImageUninitialized();

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    if(event is FetchImage) {
      yield ImageLoading();
      try {
        yield await imageRepository.getImages().then((response) {
          if(response is String) {
            return ImageError();
          } else {
            return ImageLoaded(imageUrl: response);
          }
        });
        //yield ImageLoaded(imageUrl:  imageUrls);
      } catch (_) {
        yield ImageError();
      }
    }
    if(event is UploadImage) {
      yield UploadingImage();
      try {
        final bool successUpload = await imageRepository.uploadImage(event.image, event.name, event.desc);
        yield ImageUploaded(isSuccess: successUpload);
      } catch (_) {
        yield ImageError();
      }
    }
  }
}