import 'package:flutter/material.dart';
import 'package:hello_world/my_view.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202227),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "Smart Home",
              style: TextStyle(
                  fontFamily: "SF Rounded", fontSize: 32, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Image.asset(
                  'assets/lightning.png',
                  scale: 0.99,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "11.5",
                            style: TextStyle(
                                fontFamily: "SF Rounded",
                                fontSize: 54,
                                fontWeight: FontWeight.w200,
                                color: Colors.white.withOpacity(0.78)),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "°C",
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white.withOpacity(0.7)),
                          )
                        ],
                      ),
                      Text(
                        "Temperature",
                        style: TextStyle(
                            fontFamily: 'SF Rounded',
                            fontSize: 18,
                            letterSpacing: 0.72,
                            color: Colors.white.withOpacity(0.15)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: 413,
            height: 106,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.5, color: Colors.white.withOpacity(0.28)),
                borderRadius: BorderRadius.circular(25)),
            child: Row(children: [
              Image.asset('assets/profile_pic.png'),
              Container(
                padding: EdgeInsets.only(left: 2, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your name",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "SF Rounded",
                          color: Colors.white),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.white.withOpacity(0.25),
                        ),
                        Text(
                          "Hai Ba Trung, Ha Noi",
                          style: TextStyle(
                              fontFamily: "SF Rounded",
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.25)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 70,
                height: 29,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment(0.01, 0.13),
                        end: Alignment(0.97, 0.84),
                        colors: [Color(0xff79fd7b), Color(0xff3dcd98)]),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text("OWNER",
                      style: TextStyle(
                          fontFamily: "SF Rounded",
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.black)),
                ),
              )
            ]),
          ),
          Expanded(child: MyView())
        ],
      ),
    );
  }
}
