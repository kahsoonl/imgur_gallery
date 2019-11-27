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
        final List<ImgurImageModel> imageUrls = await imageRepository.getImages();
        yield ImageLoaded(imageUrl:  imageUrls);
      } catch (_) {
        yield ImageError();
      }
    }
  }
}