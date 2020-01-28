import 'package:dart_app/src/models/photo.dart';
import 'package:http/http.dart' show Client;

class API {
  static const BASEURL = "https://jsonplaceholder.typicode.com/photos";

  final Client _client = Client();

  Future<List<Photo>> getPhotos() async {
    List<Photo> photos;

    final response = await _client.get(BASEURL);
    photos = photoFromJson(response.body);

    return photos;
  }
}
