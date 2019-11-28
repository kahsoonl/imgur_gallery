import 'dart:io';

import 'package:imgur_gallery/common/api_provider.dart';
import 'package:meta/meta.dart';

class ImageRepository {

  ImageRepository({@required this.apiProvider}) : assert(apiProvider != null);

  final APIProvider apiProvider;

  Future<dynamic> getImages() async {
    return await apiProvider.getAlbumImage();
  }

  Future<dynamic> uploadImage(File image) async {
    return await apiProvider.uploadImage(image);
  }
}