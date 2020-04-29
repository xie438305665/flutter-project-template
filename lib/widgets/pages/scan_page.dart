import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsy/common/utils/toast_util.dart';
import 'package:zsy/routes/app_navigator.dart';
import 'package:zsy/routes/app_route.dart';

///@description: 扫描
///@author xcl qq:244672784
///@Date 2020/4/27 14:38
class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  DateTime _lastPressedAt; //上次点击时间
  String _scanText;

  @override
  void initState() {
    super.initState();
    _scanText = "二维码扫描";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
          _lastPressedAt = DateTime.now();
          ToastUtil.show("再按一次退出");
          return false;
        }
        AppNavigator.backDeskTop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.grey[50],
          centerTitle: true,
          title: Text(
            "扫描",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/2.0x/ic_2x_qr_code_log.png",
                width: 100,
                height: 100,
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: 146,
                height: 46,
                child: RaisedButton(
                  color: Colors.green,
                  elevation: 2.0,
                  onPressed: scan,
                  child: Text(_scanText),
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///二维码扫描 相关配置https://pub.flutter-io.cn/documentation/barcode_scan/latest/
  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": '取消',
          "flash_on": '打开闪光灯',
          "flash_off": '关闭闪光灯',
        },
        restrictFormat: BarcodeFormat.values,
        useCamera: 8,
        autoEnableFlash: false,
        android: AndroidOptions(
          useAutoFocus: true,
        ),
      );
      ScanResult scanResult = await BarcodeScanner.scan(options: options);
      if (scanResult.format == null ||
          scanResult.format == BarcodeFormat.unknown) return;
      if (scanResult.format != BarcodeFormat.qr) {
        ToastUtil.show("二维码不规范，无法识别");
      } else {
        AppNavigator.toPush(context, AppRoute.signPage, arguments: scanResult);
      }
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = '未授予相机权限';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      ToastUtil.show(result.rawContent);
    }
  }
}
