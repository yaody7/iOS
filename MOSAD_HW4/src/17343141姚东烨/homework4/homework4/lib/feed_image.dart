import 'package:flutter/material.dart';
class my_image extends StatelessWidget{
  Widget build(BuildContext context) {
    void jump(TapDownDetails) {
      Navigator.pushNamed(context, "nameRoute");
    }
    return GestureDetector(
      onTapDown: jump, // 分析 1
      child: Image.asset('assets/images/timg.jpeg'),
    );
  }
}