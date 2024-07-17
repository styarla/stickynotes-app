import 'package:flutter/material.dart';
import 'package:todoapp/googlesheets_api.dart';
import 'package:todoapp/homepage.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GSheetsAPI().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}
