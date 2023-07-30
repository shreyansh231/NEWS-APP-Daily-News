import 'package:flutter/material.dart';
import 'package:newsapp/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blueGrey,
      title: 'Getx News App',
      theme: ThemeData(),
      home: const Home(),
    );
  }
}


