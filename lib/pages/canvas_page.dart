import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/common/res/res_colors.dart';
import 'package:flutter_project/common/utils/check_util.dart';
import 'package:flutter_project/entity/sign_entity.dart';
import 'package:flutter_project/routes/app_navigator.dart';
import 'package:orientation/orientation.dart';
import 'package:path_provider/path_provider.dart';

///@description: 画布签名
///@author xcl qq:244672784
///@Date 2020/4/27 18:34
class CanvasPage extends StatefulWidget {
  final arguments;

  CanvasPage({this.arguments});

  @override
  _CanvasPageState createState() => _CanvasPageState(arguments: this.arguments);
}

class _CanvasPageState extends State<CanvasPage> {
  final SignData arguments;

  List<Offset> _points = [];
  GlobalKey _globalKey;

  _CanvasPageState({this.arguments});

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.black),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: OutlineButton(
                  borderSide: BorderSide(color: ResColors.greenColor),
                  child: Text(
                    "重签",
                    style: TextStyle(color: ResColors.greenColor),
                  ),
                  onPressed: () {
                    setState(() {
                      _globalKey = GlobalKey();
                      _points = [];
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: RaisedButton(
                  color: ResColors.greenColor,
                  child: Text(
                    "确定",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (CheckUtil.isListEmpty(_points)) return;
                    String path = await _getPath(_globalKey);
                    if (CheckUtil.isStringNull(path)) return;
                    AppNavigator.toPop(context, arguments: path);
                    OrientationPlugin.forceOrientation(
                        DeviceOrientation.portraitUp);
                  },
                ),
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.grey[50],
            centerTitle: true,
            title: Text(
              CheckUtil.isObjectNull(this.arguments)
                  ? ""
                  : CheckUtil.isStringNull(this.arguments.name)
                      ? ""
                      : this.arguments.name,
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Center(
                child: Offstage(
                  offstage: !CheckUtil.isListEmpty(this._points),
                  child: Text(
                    "请横向签名",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ),
              Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: CheckUtil.isObjectNull(this.arguments) ||
                          CheckUtil.isListEmpty(this.arguments.classes)
                      ? []
                      : List.generate(this.arguments.classes.length,
                          (int index) {
                          return watermarkWidget(this.arguments.classes[index]);
                        })),
              RepaintBoundary(
                key: _globalKey,
                child: Stack(
                  children: [
                    GestureDetector(
                      onPanUpdate: (DragUpdateDetails details) =>
                          _addPoints(details, _globalKey),
                      onPanEnd: (DragEndDetails details) => _points.add(null),
                    ),
                    CustomPaint(painter: Painter(_points)),
                  ],
                ),
              ),
            ],
          ),
        ),
        onWillPop: () async {
          OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
          return true;
        });
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

///绘制
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
    for (var i = 0; i < this.points.length; i++) {
      if (i + 1 <= this.points.length) {
        if (this.points[i] != null && this.points[i + 1] != null) {
          canvas.drawLine(this.points[i], this.points[i + 1], mPaint);
        }
      }
    }
  }

  /// 是否重绘
  @override
  bool shouldRepaint(Painter oldDelegate) {
    return oldDelegate.points != points;
  }
}

///水印
Widget watermarkWidget(SignDataClass signDataClass) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          signDataClass.productName,
          maxLines: 1,
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          signDataClass.className,
          maxLines: 1,
          style: TextStyle(color: Colors.grey),
        )
      ],
    ),
  );
}
