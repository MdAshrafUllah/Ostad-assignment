import 'package:assignment_three/photo_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Assignment Three',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          )),
      home: const PhotoListScreen(),
    );
  }
}
