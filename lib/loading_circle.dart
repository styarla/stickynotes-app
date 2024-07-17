import 'package:flutter/material.dart';

class MyLoadingCircle extends StatelessWidget {
  const MyLoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
