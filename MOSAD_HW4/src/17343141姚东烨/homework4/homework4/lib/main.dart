import 'package:flutter/material.dart';
import 'feed_home.dart';
import 'feed_list.dart';
import 'feed_next.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(),
    //  home:SecondPage(),
      routes: {
        "nameRoute":(BuildContext context)=>new SecondPage(),
      },
    );
  }

}

