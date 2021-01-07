import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class RoomDetails extends StatefulWidget {
  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  Future getSensorData() async {
    Map<String, dynamic> jsonResponse;
    Map data = {'sensor': "1"};
    var response =
        await http.post(DotEnv().env['IBM_CLOUD'] + "/sensorData", body: data);
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
    }
    print("jsonResponse ${jsonResponse['data']}");
    setState(() {
      hum = jsonResponse['data']['humidity'].toString();
      temp = jsonResponse['data']['temperature'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getSensorData();
  }

  String temp = 'Loading';
  String hum = 'Loading';
  bool isSelectedLamp1 = false;
  bool isSelectedLamp2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(18, 20, 18, 20),
      child: StaggeredGridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          GestureDetector(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(27)),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Temperature",
                    style: TextStyle(
                        fontFamily: "SF Rounded",
                        fontSize: 21,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  Container(
                    child: StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 15))
                            .asyncMap((event) => getSensorData()),
                        builder: (context, snapshot) {
                          return Text(
                            temp + '°C',
                            style: TextStyle(
                                fontFamily: "SF Rounded",
                                fontSize: 30,
                                color: Colors.white.withOpacity(0.14)),
                          );
                        }),
                  )
                ],
              ),
            ),
          )),
          GestureDetector(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(27)),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Humidity",
                    style: TextStyle(
                        fontFamily: "SF Rounded",
                        fontSize: 21,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  // Visibility(
                  //   visible: widget.image == null ? false : true,
                  //   child: Center(
                  //       child: Container(
                  //     height: 100,
                  //     width: 100,
                  //     child: widget.image ?? null,
                  //   )),
                  // ),
                  Text(
                    hum + "%",
                    style: TextStyle(
                        fontFamily: "SF Rounded",
                        fontSize: 30,
                        color: Colors.white.withOpacity(0.14)),
                  )
                ],
              ),
            ),
          )),
          GestureDetector(
              onTap: () {
                setState(() {
                  isSelectedLamp1 = !isSelectedLamp1;
                });
                if (isSelectedLamp1) {
                  turnLamp("1");
                } else {
                  turnLamp("0");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(27)),
                child: Container(
                  decoration: isSelectedLamp1
                      ? BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color(0xff5fe686).withOpacity(0.26),
                              Color(0xff262d2e).withOpacity(0.23)
                            ],
                            radius: 0.72,
                            center: Alignment(0, 0),
                          ),
                          border: Border.all(
                              width: 4, color: const Color(0xff5fe686)),
                          borderRadius: BorderRadius.circular(27),
                          boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 3),
                                  blurRadius: 6,
                                  color: Color(0xff000000).withOpacity(0.16))
                            ])
                      : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Lamp",
                        style: TextStyle(
                            fontFamily: "SF Rounded",
                            fontSize: 21,
                            color: Colors.white.withOpacity(0.7)),
                      ),
                      Text(
                        isSelectedLamp1 ? "On" : "OFF",
                        style: TextStyle(
                            fontFamily: "SF Rounded",
                            fontSize: 21,
                            color: Colors.white.withOpacity(0.14)),
                      )
                    ],
                  ),
                ),
              ))
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 220),
          StaggeredTile.extent(1, 220),
          StaggeredTile.extent(1, 150)
        ],
      ),
    );
  }

  turnLamp(String control) async {
    var jsonResponse;
    Map data = {'control': control};
    var response =
        await http.post(DotEnv().env['IBM_CLOUD'] + "/led", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response : ${response.body}');
    }
    print(jsonResponse);
  }
}
