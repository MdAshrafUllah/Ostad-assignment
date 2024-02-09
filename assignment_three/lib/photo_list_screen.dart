import 'package:assignment_three/data_fatch.dart';
import 'package:assignment_three/photo.dart';
import 'package:assignment_three/photo_detail_screen.dart';
import 'package:flutter/material.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({super.key});

  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  late Future<List<Photo>> _photoList;

  @override
  void initState() {
    super.initState();
    _photoList = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery App'),
      ),
      body: FutureBuilder<List<Photo>>(
        future: _photoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Photo>? photos = snapshot.data;
            return ListView.builder(
              itemCount: photos!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(photos[index].title),
                  leading: Image(
                    image: NetworkImage(photos[index].thumbnailUrl),
                    width: 50,
                    height: 50,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhotoDetailScreen(photo: photos[index]),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
