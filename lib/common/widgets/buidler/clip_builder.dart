import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ClipBuilder {
  static const OVAL = 100;

  static const RECT = 101;

  static const RRECT = 102;

  static const PATH = 103;

  //裁剪类型
  final int clipType;
  final Clip clipBehavior;
  final CustomClipper<Rect> clipper;

  //ClipRRect 圆角
  final BorderRadius borderRadius;

  const ClipBuilder({
    this.clipType = OVAL,
    this.clipBehavior,
    this.clipper,
    this.borderRadius,
  });
}
