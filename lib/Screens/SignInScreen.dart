import 'package:flutter/material.dart';
import 'package:hello_world/Screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/App.png'))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.email), onPressed: null),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 20, left: 10),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration:
                                      InputDecoration(hintText: 'Email'),
                                )))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.lock), onPressed: null),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 20, left: 10),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration:
                                      InputDecoration(hintText: 'Password'),
                                ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 60,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            signIn(
                                emailController.text, passwordController.text);
                          },
                          color: Color(0xFF00a79B),
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'SignUp');
                    },
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'SIGN UP',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var jsonResponse;
    print(data);

    var response = await http
        .post("http://" + DotEnv().env['API_URL'] + "/users/login", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("email", jsonResponse['user']['email']);
        sharedPreferences.setString("name", jsonResponse['user']['name']);
        sharedPreferences.setString("_id", jsonResponse['user']['_id']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            ModalRoute.withName('/Home'));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
}
