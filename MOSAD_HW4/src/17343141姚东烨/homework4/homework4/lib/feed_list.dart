import 'package:flutter/material.dart';
import 'feed_image.dart';
class feed_list extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return(
        ListView.separated(
            itemCount: 6,
            itemBuilder: (context, index) {
             return Container(
                  child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                  height: 72,
                                  width: 72,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child:
                                      ClipOval(
                                          child: Image.asset(
                                              'assets/images/dog.jpeg',
                                              height: 40)
                                      )
                                  )
                              ),
                              Text(
                                "Andrew", style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                        Container(
                           // child:IconButton(icon: ImageIcon(AssetImage("assets/images/timg.jpeg")), onPressed: null)
                        //    child:Image.asset('assets/images/timg.jpeg'),
                              child:my_image(),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.favorite_border,color: Colors.black,)),
                              IconButton(icon: Icon(Icons.crop_3_2,color:Colors.black)),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                  height: 72,
                                  width: 72,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child:
                                      ClipOval(
                                          child: Image.asset(
                                              'assets/images/dog.jpeg',
                                              height: 40)
                                      )
                                  )
                              ),
                              Container(
                                width: 150,
                                child:
                                TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: null,
                                    border: InputBorder.none,
                                    labelText: "Add a comment...",
                                  ),

                                ),
                              )

                            ],
                          ),
                        ),
                      ]

                  )
              );
            },
          separatorBuilder: (context, index) => Divider(height: .0),

        )
    );
  }
}