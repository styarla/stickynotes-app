import 'package:flutter/material.dart';
import 'package:todoapp/googlesheets_api.dart';
import 'package:todoapp/textbox.dart';

class MyNotesGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: GSheetsAPI.currentNotes.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return MyTextBox(text: GSheetsAPI.currentNotes[index]);
        });
  }
}
