import 'package:flutter/material.dart';

class custshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double hieght = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, hieght - 50);
    path.quadraticBezierTo(width / 2, hieght, width, hieght - 50);
    path.lineTo(width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
