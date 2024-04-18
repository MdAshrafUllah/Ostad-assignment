import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> imagesList = [];
  bool _isLoading = false;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      }
    });
  }

  Future uploadFile() async {
    setState(() {
      _isLoading = true;
    });
    if (_photo == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      final fileName = '${DateTime.now()}.jpg';
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(_photo!);
      final imageUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('images').add({
        'image': imageUrl,
      });
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 6, 105, 97),
        title: const Text('Storage'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('images').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final List<String> urls =
              snapshot.data!.docs.map((doc) => doc['image'] as String).toList();

          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(
                    itemCount: urls.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(urls[index]);
                    },
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: imgFromGallery,
        tooltip: 'Add Image',
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 6, 105, 97),
        child: const Icon(
          Icons.image,
          color: Colors.white,
        ),
      ),
    );
  }
}
