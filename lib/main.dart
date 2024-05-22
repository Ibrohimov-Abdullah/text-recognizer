import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:handwriting_to_txt/pages/camera_regret_page.dart';
import 'package:handwriting_to_txt/pages/main_page.dart';
import 'package:handwriting_to_txt/pages/result_screen.dart';
import 'package:handwriting_to_txt/pages/splash_page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
