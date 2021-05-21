import 'package:flutter/material.dart';
import 'package:flutter_project/common/utils/check_util.dart';
import 'package:flutter_project/common/widgets/buidler/border_builder.dart';

/// @description:Text封装
/// @author xcl qq:244672784
/// @Date 2021/5/15 13:01
/// Text属性介绍地址 https://blog.csdn.net/chenlove1/article/details/84574651
class XText extends StatefulWidget {
  final String str;

  //文字样式
  final TextStyle style;

  //文字摆放位置
  final TextAlign align;

  //文字方向
  final TextDirection direction;

  //文字最多显示几行
  final int maxLines;

  //是否自动换行
  final bool softWrap;

  //文字超出设定宽度后，显示方式
  final TextOverflow overflow;

  //文本拼接
  final TextSpan span;

  //这玩意设置完成之后  Text 原本设置的height将失效  具体说明 https://zhuanlan.zhihu.com/p/144426357
  final StrutStyle strutStyle;

  //选择区域特定字形的语言环境 基本用不到
  final Locale locale;

  // 每个逻辑像素的字体像素数
  final double scaleFactor;

  //内容播报  针对盲人或者视觉不好的人  基本用不到
  final String semanticsLabel;

  //测量一行或多行文本宽度的不同方式
  final TextWidthBasis widthBasis;

  //文字大小
  final double fontSize;

  //文字颜色
  final Color color;

  //Text背景
  final Color backgroundColor;

  //字体  italic/normal   斜体/直立
  final FontStyle fontStyle;

  //字体粗细
  final FontWeight fontWeight;

  //文字阴影
  final List<Shadow> shadows;

  //BorderBuilder
  final BorderBuilder borderBuilder;

  //单击
  final GestureTapCallback onPressed;

  //长按
  final GestureLongPressCallback onLongPressed;

  XText(
    this.str, {
    Key key,
    this.align = TextAlign.center,
    this.maxLines = 1,
    this.direction = TextDirection.ltr,
    this.softWrap = true,
    this.overflow = TextOverflow.ellipsis,
    this.span,
    this.style,
    this.strutStyle,
    this.scaleFactor,
    this.locale,
    this.semanticsLabel,
    this.widthBasis,
    this.fontSize,
    this.color,
    this.backgroundColor,
    this.fontStyle,
    this.fontWeight,
    this.shadows,
    this.borderBuilder,
    this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  @override
  _XTextState createState() => _XTextState();
}

class _XTextState extends State<XText> {
  @override
  Widget build(BuildContext context) {
    return _getBuildWidget(!CheckUtil.isObjectNull(widget.borderBuilder)
        ? _getTextBorderWidget()
        : CheckUtil.isObjectNull(widget.span) ? _getText() : _getTextRich());
  }

  Text _getText() {
    return Text(
      widget.str,
      maxLines: widget.maxLines,
      locale: widget.locale,
      textAlign: widget.align,
      textDirection: widget.direction,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      style:
          CheckUtil.isObjectNull(widget.style) ? _getTextStyle() : widget.style,
      strutStyle: widget.strutStyle,
      textScaleFactor: widget.scaleFactor,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.widthBasis,
    );
  }

  Text _getTextRich() {
    return Text.rich(
      widget.span,
      maxLines: widget.maxLines,
      locale: widget.locale,
      textAlign: widget.align,
      textDirection: widget.direction,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      style:
          CheckUtil.isObjectNull(widget.style) ? _getTextStyle() : widget.style,
      strutStyle: widget.strutStyle,
      textScaleFactor: widget.scaleFactor,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.widthBasis,
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(
        fontSize: widget.fontSize,
        fontStyle: widget.fontStyle,
        fontWeight: widget.fontWeight,
        color: widget.color,
        backgroundColor: widget.backgroundColor,
        shadows: widget.shadows);
  }

  ///边框Text
  Widget _getTextBorderWidget() {
    return Container(
      alignment: Alignment.center,
      margin: CheckUtil.isObjectNull(widget.borderBuilder.margin)
          ? EdgeInsets.all(0)
          : widget.borderBuilder.margin,
      child: CheckUtil.isObjectNull(widget.borderBuilder.padding)
          ? CheckUtil.isObjectNull(widget.span) ? _getText() : _getTextRich()
          : Padding(
              padding: widget.borderBuilder.padding,
              child: _getText(),
            ),
      decoration: BoxDecoration(
        color: widget.borderBuilder.radiusBorderBgColor,
        borderRadius: BorderRadius.circular(widget.borderBuilder.radius),
        border: Border.all(
            color: widget.borderBuilder.radiusBorderColor,
            width: widget.borderBuilder.radiusBorderWidth),
      ),
    );
  }

  Widget _getBuildWidget(Widget childWidget) {
    return CheckUtil.isObjectNull(widget.onPressed) &&
            CheckUtil.isObjectNull(widget.onLongPressed)
        ? childWidget
        : GestureDetector(
            child: childWidget,
            onTap: widget.onPressed,
            onLongPress: widget.onLongPressed,
          );
  }
}
