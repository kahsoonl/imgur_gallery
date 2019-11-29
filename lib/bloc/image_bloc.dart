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
            if(response is List<ImgurImageModel> && response.isEmpty) {
              return ImageEmpty();
            } else {
              return ImageLoaded(imageUrl: response);
            }
          }
        });
      } catch (_) {
        yield ImageError();
      }
    }
  }
}