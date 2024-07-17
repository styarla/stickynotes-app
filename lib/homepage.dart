import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoapp/button.dart';
import 'package:todoapp/googlesheets_api.dart';
import 'package:todoapp/loading_circle.dart';
import 'package:todoapp/notes_grid.dart';
//import 'package:todoapp/textbox.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState (() {}));
  }

  void _post () {
    GSheetsAPI.insert(_controller.text);
    _controller.clear();
    setState(() {});
  }

  void startLoading () {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GSheetsAPI.loading == false){
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if (GSheetsAPI.loading == true){
      startLoading();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Post A Note', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink[700]),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.pink[50],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GSheetsAPI.loading == true? MyLoadingCircle() : MyNotesGrid())),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'enter text',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                        },), 
                    )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('@shrinatyarla'),
                    ),
                    MyButton(
                      text: 'P O S T',
                      function: _post,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}