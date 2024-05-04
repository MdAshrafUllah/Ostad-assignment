import 'package:flutter/material.dart';
import 'package:google_map/mapscreen.dart';

void main() {
  runApp(const MapApp());
}

class MapApp extends StatelessWidget {
  const MapApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map',
      home: MapScreen(),
    );
  }
}
