import 'package:flutter/material.dart';
import 'package:hello_world/Components/RoomDetails.dart';

//ignore: must_be_immutable
class Room extends StatefulWidget {
  String title;
  Room({this.title});
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202227),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 25, top: 30),
            child: Positioned(
                top: 20,
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontFamily: "SF Rounded",
                          fontSize: 32,
                          color: Colors.white),
                    )
                  ],
                )),
          ),
          SizedBox(height: 50),
          Expanded(child: RoomDetails())
        ],
      ),
    );
  }
}
