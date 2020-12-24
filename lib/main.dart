import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hello_world/Screens/Home.dart';
import 'package:hello_world/Screens/SignInScreen.dart';
import 'package:hello_world/Screens/SignUpScreen.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Home(),
      initialRoute: 'Home',
      routes: {
        'SignIn': (context) => SignInScreen(),
        'SignUp': (context) => SignUpScreen(),
        'Home': (context) => Home(),
      },
    );
  }
}
