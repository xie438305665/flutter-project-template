import 'package:flutter/material.dart';

/// @description:Button封装
/// @author xcl qq:244672784
/// @Date 2021/5/15 13:01
class XBtn extends StatefulWidget {

  @override
  _XBtnState createState() => _XBtnState();
}

class _XBtnState extends State<XBtn> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

///枚举
enum XBtnType {
  raised,
  floating,
  flat,
  icon,
  popupMenu,
  text,
  outline,
  elevated,
  back,
  close
}
