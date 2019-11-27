import 'package:http_interceptor/http_interceptor.dart';
import 'package:imgur_gallery/common/api_interceptor.dart';
import 'dart:convert';

class APIProvider {
  final String _baseUrl = "https://api.imgur.com/";
  final String _clientId = "6262c5ede914c3a";
  final String _clientSecret = "03e331d7db8c79360305b21253cb8c417e15ccad";
  final String _albumId = "7k2HpyE";
  final String _albumDeleteHash = "t4tgAehfXFdzxJG";

  final _http = HttpWithInterceptor.build(interceptors: [LoggingInterceptor()]);

  Future<dynamic> getAlbumImage() async {
    var response = await _http.post(_baseUrl + "3/album/$_albumDeleteHash/images",
        headers: {'Authorization': 'Client-ID $_clientId'});
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    }
    return 'error';
  }

  Future<dynamic> addImageToAlbum() async {
    var response = await _http.post(
        _baseUrl + "3/album/$_albumDeleteHash/add",
        headers: {'Authorization': 'Client-ID $_clientId'});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return 'error';
  }
}
