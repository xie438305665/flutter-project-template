import 'package:flutter/material.dart';
import 'package:zsy/navigator/app_navigator.dart';

///@description: 扫描
///@author xcl qq:244672784
///@Date 2020/4/27 14:38
class ScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "scan_page",
      home: Scaffold(
        appBar: AppBar(
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
                  onPressed: () async => AppNavigator.toPush(
                      context, "/signPage",
                      arguments: "2222222"),
                  child: Text("二维码扫描"),
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
