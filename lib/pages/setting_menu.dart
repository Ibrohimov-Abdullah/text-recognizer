import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Convert Languages.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 25),),
            const SizedBox(height: 50,),
            TextButton(onPressed: (){}, child: const Text(
              "ENGLISH",
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
            ) ),
            const SizedBox(height: 20,),
            TextButton(onPressed: (){}, child: const Text(
              "Русский",
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),
            ) ),
          ],
        ),
      ),
    );
  }
}

