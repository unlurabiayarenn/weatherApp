import 'package:flutter/material.dart';
import 'package:weatherapp/screens/loading_secreen.dart';
import 'package:weatherapp/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
      //home: MainScreen(),
    );
  }
}
