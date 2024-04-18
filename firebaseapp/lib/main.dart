import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseapp/app.dart';
import 'package:firebaseapp/firebase_options.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
