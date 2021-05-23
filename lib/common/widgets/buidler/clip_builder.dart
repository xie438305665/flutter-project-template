import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

///裁剪枚举
enum ClipType{
  oval,
  rect,
  rRect,
  path,
}

class ClipBuilder {
  //裁剪类型
  final ClipType clipType;
  final Clip clipBehavior;
  final CustomClipper<Rect> clipper;

  //ClipRRect 圆角
  final BorderRadius borderRadius;

  const ClipBuilder({
    this.clipType = ClipType.oval,
    this.clipBehavior,
    this.clipper,
    this.borderRadius,
  });
}
