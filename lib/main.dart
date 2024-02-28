import 'package:flutter/material.dart';
import 'package:real_wether/home.dart';

void main(){
  runApp(const Directionality(
      textDirection: TextDirection.ltr, // or TextDirection.rtl
      child: Myapp(),
    ),);
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      home: Weat(),
    );
  }
}