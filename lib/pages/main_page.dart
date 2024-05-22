import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:handwriting_to_txt/pages/camera_regret_page.dart';
import 'package:handwriting_to_txt/pages/result_screen.dart';
import 'package:handwriting_to_txt/pages/setting_menu.dart';
import 'package:permission_handler/permission_handler.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;

  late final Future<void> _future;

  CameraController? _cameraController;

  final _textRecognizer = TextRecognizer();

  // late Future<String> _future = Future<String>.value('Initial value');
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return Stack(
            children: [
              // show the camera feed
              if (_isPermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _initCameraController(snapshot.data!);

                      return Center(child: CameraPreview(_cameraController!));
                    } else {
                      return const LinearProgressIndicator();
                    }
                  },
                ),
              Scaffold(
                  // appBar: AppBar(
                  //   title: const Text("Teks  "),
                  // ),
                  backgroundColor:
                      _isPermissionGranted ? Colors.transparent : null,
                  body: _isPermissionGranted
                      ? Column(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      child: IconButton(
                                        onPressed: (){},
                                        icon: const Icon(
                                          Icons.image_outlined,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text("Gallery", style: TextStyle(
                                      color: Colors.white
                                    ),)
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: MaterialButton(
                                    height: 50,
                                    minWidth: 50,
                                    color: Colors.yellow,
                                    splashColor: Colors.purple,
                                    onPressed: _scanImage,
                                    child: const Text("Scan text"),
                                  ),
                                ),
                                /// Future another button
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingMenu()));
                                        },
                                        icon: const Icon(
                                          Icons.settings,
                                          size: 35,
                                          color: Colors.white,
                                        )
                                    ),
                                    const Text(
                                      "Languages\nSettings",
                                      style: TextStyle(
                                      color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w800
                                    ),
                                    )
                                  ],
                                )
                              ],
                            ),
                                const SizedBox(
                                  height: 5,
                                )
                          ],
                        )
                      : const NotAllowedPage())
            ],
          );
        });
  }

  /// start camera
  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  ///dispose
  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    // Select the first camera
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  /// Camera selected
  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);

    await _cameraController?.initialize();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  /// Scanning image
  Future<void> _scanImage() async {
    if (_cameraController == null) {
      return;
    }
    final navigator = Navigator.of(context);

    /// text scanning if something happens (catching error)
    try {
      final pictureFile = await _cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ResultScreen(text: recognizedText.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Qandaydur xato kelib chiqdi text scanerda'),
        ),
      );
    }
  }
}
