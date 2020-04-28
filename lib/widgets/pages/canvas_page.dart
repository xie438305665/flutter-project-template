import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zsy/common/utils/toast_util.dart';

///@description: 画布签名
///@author xcl qq:244672784
///@Date 2020/4/27 18:34
class CanvasPage extends StatefulWidget {
  @override
  _CanvasPageState createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: OutlineButton(
              borderSide: BorderSide(color: Colors.green),
              child: Text(
                "重签",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
            alignment: Alignment.center,
            child: RaisedButton(
              color: Colors.green,
              child: Text(
                "确定",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
        title: Text(
          "名称",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Offstage(
              offstage: false,
              child: Text(
                "请横向签名",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: listWidget(),
          ),
          SignWidget(),
        ],
      ),
    );
  }
}

class SignWidget extends StatefulWidget {
  @override
  _SignWidgetState createState() => _SignWidgetState();
}

class _SignWidgetState extends State<SignWidget> {
  List<Offset> _points = [];
  GlobalKey _globalKey;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (DragUpdateDetails details) =>
                _addPoints(details, _globalKey),
            onPanEnd: (DragEndDetails details) => _points.add(null),
          ),
          CustomPaint(painter: Painter(_points)),
          RaisedButton(
            onPressed: () async {
              String path = await _getPath(_globalKey);
              ToastUtil.show(path);
            },
            child: Text("获取位置"),
          ),
        ],
      ),
    );
  }

  ///添加轨迹点
  void _addPoints(DragUpdateDetails details, GlobalKey globalKey) {
    RenderBox referenceBox = _globalKey.currentContext.findRenderObject();
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    double maxW = referenceBox.size.width;
    double maxH = referenceBox.size.height;
    // 校验画板范围
    if (localPosition.dx <= 0 || localPosition.dy <= 0) return;
    if (localPosition.dx > maxW || localPosition.dy > maxH) return;
    referenceBox.globalToLocal(details.globalPosition);
    setState(() {
      _points = List.from(_points)..add(localPosition);
    });
  }

  /// 获取保存文件的路径
  Future<String> _getPath(GlobalKey globalKey) async {
    Directory tempDir = await getTemporaryDirectory();
    String toFilePath = '${tempDir.path}/ims/sign.png';
    File toFile = File(toFilePath);
    bool exists = await toFile.exists();
    if (exists) {
      await toFile.delete();
    }
    await toFile.create(recursive: true);
    return _capturePng(toFile, globalKey);
  }

  /// 截图，并且返回图片的缓存地址
  Future<String> _capturePng(File toFile, GlobalKey globalKey) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    var image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    toFile.writeAsBytes(pngBytes);
    return toFile.path;
  }
}

class Painter extends CustomPainter {
  Painter(this.points);

  List<Offset> points;
  Paint mPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (mPaint == null) {
      mPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 6
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.bevel;
    }
    if (this.points == null || this.points.length < 0) return;
    for (var i = 0; i < this.points.length; ++i) {
      if (this.points[i] != null && this.points[i + 1] != null) {
        canvas.drawLine(this.points[i], this.points[i + 1], mPaint);
      }
    }
  }

  /// 是否重绘
  @override
  bool shouldRepaint(Painter oldDelegate) {
    return oldDelegate.points != points;
  }
}

List<Widget> listWidget() {
  List<Widget> list = [];
  for (var i = 0; i < 200; ++i) {
    list.add(watermarkWidget("51651416644654"));
  }
  return list;
}

Widget watermarkWidget(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.black26),
  );
}
