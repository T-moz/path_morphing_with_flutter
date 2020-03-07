import 'package:flutter/material.dart';

import 'main.dart';

class DigitBoxClipper extends CustomClipper<Rect> {
  const DigitBoxClipper(this.viewBox);

  final ViewBox viewBox;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(-5.0, -5.0, viewBox.width + 5.0, viewBox.height + 5.0);

  @override
  bool shouldReclip(DigitBoxClipper oldClipper) =>
      oldClipper.viewBox != viewBox;
}

class DigitClipper extends CustomClipper<Path> {
  const DigitClipper(this.path);

  final Path path;

  @override
  Path getClip(Size size) => path;

  @override
  bool shouldReclip(DigitClipper oldClipper) => oldClipper.path != path;
}
