import 'package:http_interceptor/http_interceptor.dart';
import 'package:imgur_gallery/common/api_interceptor.dart';

class APIProvider {
  final String _baseUrl = "http://api.heragowns.com/mobile/";
  final String _clientId = "6262c5ede914c3a";
  final String _clientSecret = "03e331d7db8c79360305b21253cb8c417e15ccad";

  final _http = HttpWithInterceptor.build(interceptors: [LoggingInterceptor()]);

//  Future<HomeDataModel> getGownList(String title, String tags) async {
//    var response = await _http.post(_baseUrl + "get-gown-list.php", body: { 'title': title, 'tags': tags });
//    if(response.statusCode == 200) {
//      return HomeDataModel.fromJson(json.decode(response.body));
//    }
//    return HomeDataModel.withError(response.body);
//  }
}