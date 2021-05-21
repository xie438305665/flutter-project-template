import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @description:
/// @author xcl qq:244672784
/// @Date 2021/5/16 14:51
class BorderBuilder {
  //圆角
  final double radius;

  //圆角边框宽度
  final double radiusBorderWidth;

  //圆角边框颜色
  final Color radiusBorderColor;

  //圆角填充颜色
  final Color radiusBorderBgColor;

  //内边距
  final EdgeInsetsGeometry padding;

  //外边距
  final EdgeInsetsGeometry margin;

  const BorderBuilder({
    this.radius = 6,
    this.radiusBorderWidth = 1,
    this.radiusBorderColor,
    this.radiusBorderBgColor,
    this.padding,
    this.margin,
  });
}
