import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Andrew',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/timg.jpeg'),
        ],
      )

    );
  }
}
