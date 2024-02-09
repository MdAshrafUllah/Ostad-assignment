import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assignment_three/photo.dart';

Future<List<Photo>> fetchPhotos() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(response.body);
    List<Photo> photos =
        jsonResponse.map((model) => Photo.fromJson(model)).toList();
    return photos;
  } else {
    throw Exception('Failed to load photos');
  }
}
