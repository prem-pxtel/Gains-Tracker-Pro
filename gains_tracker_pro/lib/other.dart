import 'package:flutter/material.dart';
import 'randfuncs.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Center(child: Text('© 2023 Gains Corp.\n\n\n')),
        const Center(child: Text('San B. & Prem P.')),
        Container(
        alignment: Alignment.center,
        child: ListView.builder(
          itemBuilder: (_, index) {
            return Container(
              color: randColor(),
              width: 500,
              height: 500,
            );
          },
        ),
      ),
      ]
      )
    );
  }
}