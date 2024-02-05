import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final double width;
  final double height;
  Bar(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(color: Colors.blue[900]),
    );
  }
}
