import 'package:flutter/material.dart';
import 'package:hello_world/Components/RaiseRadientButton.dart';
import 'package:hello_world/Screens/SignInScreen.dart';
import 'package:hello_world/custom_nav_bar.dart';
import 'package:hello_world/my_view.dart';
import "package:shared_preferences/shared_preferences.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null ||
        sharedPreferences.getString("name") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SignInScreen()),
          ModalRoute.withName('/SignIn'));
    }
  }

  Future<String> createRoom(BuildContext context) {
    TextEditingController name = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Input Room Name"),
            backgroundColor: Colors.blueGrey[50],
            content: TextField(
              controller: name,
              decoration: InputDecoration(hintText: "Room"),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Submit"),
                onPressed: () {
                  Navigator.of(context).pop(name.text.toString());
                },
              )
            ],
          );
        });
  }

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
                    fontFamily: "SF Rounded",
                    fontSize: 32,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  Container(
                    width: 70,
                    height: 29,
                    child: Center(
                      child: RaisedGradientButton(
                          child: Text(
                            'LOGOUT',
                            style: TextStyle(
                                fontFamily: "SF Rounded",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment(0.01, 0.13),
                            end: Alignment(0.97, 0.84),
                            colors: <Color>[
                              Color(0xff79fd7b),
                              Color(0xff3dcd98)
                            ],
                          ),
                          onPressed: () {
                            sharedPreferences.clear();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignInScreen()),
                                ModalRoute.withName('/SignIn'));
                          }),
                    ),
                  )
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
                  padding: EdgeInsets.only(left: 2, right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sharedPreferences.getString("name") == null
                            ? ""
                            : sharedPreferences.getString("name"),
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
              ]),
            ),
            Expanded(child: MyView())
          ],
        ),
        floatingActionButton: Transform.scale(
          scale: 1.1,
          child: Transform.translate(
            offset: Offset(0, 18),
            child: GestureDetector(
              onTap: () {
                createRoom(context).then((value) => print(value));
                print("nav tapped");
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(0.5, 0),
                        end: Alignment(0.5, 1),
                        colors: [Color(0xff7afc79), Color(0xff3ccb97)]),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 18,
                          color: Color(0xff7afc79).withOpacity(0.26))
                    ]),
                child: Image.asset(
                  'assets/plus.png',
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 18.0),
          child: ClipPath(
            clipper: NavbarClipper(),
            child: BottomAppBar(
              elevation: 0,
              color: Color(0xff3f4144).withOpacity(0.31),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.person_pin,
                        color: Colors.white.withOpacity(0.1),
                        size: 30,
                      ),
                      onPressed: null),
                  IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white.withOpacity(0.1),
                        size: 30,
                      ),
                      onPressed: null),
                  SizedBox(
                    height: 80,
                    width: 60,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.message,
                        color: Colors.white.withOpacity(0.1),
                        size: 30,
                      ),
                      onPressed: null),
                  IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white.withOpacity(0.1),
                        size: 30,
                      ),
                      onPressed: null),
                ],
              ),
            ),
          ),
        ));
  }
}
