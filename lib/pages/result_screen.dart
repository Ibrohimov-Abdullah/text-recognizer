import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget{

  final String text;


  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/photos/result_image.jpg"),
            fit: BoxFit.cover
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            const SizedBox(
              child: Text(
                "Result",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              padding: const EdgeInsets.all(20),
              child: SelectableText(text),
            ),
          ],
        ),
      ),
    ),
  );
}
