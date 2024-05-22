import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotAllowedPage extends StatefulWidget {
  const NotAllowedPage({super.key});

  @override
  State<NotAllowedPage> createState() => _NotAllowedPageState();
}

class _NotAllowedPageState extends State<NotAllowedPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 100,),
              Container(
                height: 700,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/photos/eror_back.png",),
                        fit: BoxFit.cover
                    )
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
                child: const Text(
                  "Cameraga ruxsat berilmadi!\n Iltimos ruxhsat bering.",
                  style: TextStyle(
                    color: Colors.red,
                    shadows: [
                      Shadow(color: Colors.black, blurRadius: 40,offset: Offset(2, 3))
                    ],
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
