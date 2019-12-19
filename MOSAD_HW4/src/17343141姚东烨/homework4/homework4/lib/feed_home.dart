import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'feed_list.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePage createState(){
    return new _MyHomePage();
  }
}
class _MyHomePage extends State<MyHomePage> {
   static const platform = const MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = '100%';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;

    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = '$result%';

    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:
          IconButton(icon: Icon(Icons.camera_alt, color: Colors.black,),
              onPressed: () {},
              padding: const EdgeInsets.only(left: 12.0)),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.only(right:12.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.battery_unknown),
                    onPressed: () {
           //         Navigator.pushNamed(context, "nameRoute");
                        _getBatteryLevel();
           //             _batteryLevel="123";

                    },
                   padding: const EdgeInsets.only(left: 12),
                    tooltip: "Home",
                  ),
                  Text(_batteryLevel,style: TextStyle(fontWeight: FontWeight.bold),)
                ]
              )
            )
          ],
          title: Text('Helo',),
          centerTitle: true,
        ),
        body: new feed_list(),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home,color: Colors.black,)),
            IconButton(icon: Icon(Icons.search)),
            IconButton(icon: Icon(Icons.add_box)),
            IconButton(icon: Icon(Icons.favorite)),
            IconButton(icon: Icon(Icons.account_box))
          ],
        ),
      ),

    );
  }


}