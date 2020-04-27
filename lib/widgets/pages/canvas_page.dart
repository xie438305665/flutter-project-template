import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///@description: 画布签名
///@author xcl qq:244672784
///@Date 2020/4/27 18:34
class CanvasPage extends StatefulWidget {
  @override
  _CanvasPageState createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: "canvas_page",
      home: Scaffold(
        appBar: AppBar(
          title: Text("canvas_page"),
        ),
        body: Container(
          child: Text("canvas_page"),
        ),
      ),
    );
  }
}
