import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:imgur_gallery/common/api_interceptor.dart';
import 'dart:convert';

import 'package:imgur_gallery/model/imgur_image_model.dart';

class APIProvider {
  final String _baseUrl = "https://api.imgur.com";
  final String _clientId = "6262c5ede914c3a";
  final String _clientSecret = "03e331d7db8c79360305b21253cb8c417e15ccad";
  final String _albumId = "GWCFsk8";
  final String _albumDeleteHash = "o7ErrdHLNjc59Dz";

  final _http = HttpWithInterceptor.build(interceptors: [LoggingInterceptor()]);

  Future<dynamic> getAlbumImage() async {
    var response = await _http.get(
        '$_baseUrl/3/album/$_albumId/images',
        headers: {'Authorization': 'Client-ID $_clientId'});
    if (response.statusCode == 200 && json.decode(response.body)['success']) {
      var list = json.decode(response.body)['data'] as List;
      return list.map((item) => ImgurImageModel.fromJson(item)).toList();
    }
    return 'error';
  }

  Future<bool> uploadImage(String image, String name) async {
    var response = await _http.post('$_baseUrl/3/upload', headers: {
      'Authorization': 'Client-ID $_clientId'
    }, body: {
      'image': image,
      'type': 'base64',
      'name': name,
      'title': name,
      'album': _albumDeleteHash
    });
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'];
    }
    return false;
  }

  Future<dynamic> addImageToAlbum() async {
    var response = await _http.post('$_baseUrl/3/album/$_albumDeleteHash/add',
        headers: {'Authorization': 'Client-ID $_clientId'});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return 'error';
  }
}
