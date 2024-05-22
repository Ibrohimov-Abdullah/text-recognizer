import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _timeOf();
  }

  _timeOf() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/photos/splash_image.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 250,
            ),
            const Icon(
              Icons.abc,
              size: 200,
              color: Colors.white,
              shadows: [
                Shadow(
                    color: CupertinoColors.black,
                    offset: Offset(2, 8),
                    blurRadius: 15)
              ],
            ),
            const Text(
              "Text convertor",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  shadows: [Shadow(color: Colors.black,offset: Offset(2,8), blurRadius: 15)]),
            ),
            Container(
              margin: const EdgeInsets.only(top: 220, left: 150),
              child: const Text(
                "owner: Abdulloh",
                style: TextStyle(fontSize: 18, color: Colors.white, shadows: [
                  Shadow(
                      color: CupertinoColors.black,
                      blurRadius: 200,
                      offset: Offset(1, 5))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
