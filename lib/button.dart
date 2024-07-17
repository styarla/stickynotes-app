import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final text;
  final function;


  const MyButton({this.function, this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[600],
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
