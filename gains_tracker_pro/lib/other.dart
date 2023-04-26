import 'package:flutter/material.dart';
import 'dart:math';

Color randColor() {
  int a = Random().nextInt((255));
  int r = Random().nextInt((255));
  int g = Random().nextInt((255));
  int b = Random().nextInt((255));
  Color randColor = Color.fromARGB(a, r, g, b);
  return randColor;
}

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView.builder(itemBuilder: (_, index) {
          return Container(
            color: randColor(),
            width: 500,
            height: 500,
          );},
        ),
      ),
    );
  }
}