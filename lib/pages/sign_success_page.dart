import 'package:flutter/material.dart';
import 'package:flutter_project/common/res/res_colors.dart';
import 'package:flutter_project/entity/sign_entity.dart';
import 'package:flutter_project/routes/app_navigator.dart';
import 'package:flutter_project/routes/app_route.dart';

///@description: 签名成功班级展示
///@author xcl qq:244672784
///@Date 2020/6/23
class SignSuccessPage extends StatefulWidget {
  final arguments;

  SignSuccessPage({this.arguments});

  @override
  _SignSuccessPageState createState() =>
      _SignSuccessPageState(arguments: this.arguments);
}

class _SignSuccessPageState extends State<SignSuccessPage> {
  final List<SignDataClass> arguments;

  _SignSuccessPageState({this.arguments});

  Set<String> _setMap = Set();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: null,
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Image.asset("images/ic_success.png"),
            Text("上传成功"),
            Container(
              height: 10,
              color: Colors.grey.shade200,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
                  color: ResColors.greenColor,
                  width: 1,
                  height: 18,
                ),
                Expanded(
                    child: Text(
                  "共上传${_countClazz()}个班级",
                  style: TextStyle(fontSize: 16),
                )),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "返回",
                      style:
                          TextStyle(color: ResColors.greenColor, fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    AppNavigator.toPushReplacementNamed(
                        context, AppRoute.SCAN_PAGE,
                        arguments: true);
                  },
                ),
              ],
            ),
            Container(
              height: 1,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(bottom: 10),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Container(height: 1, color: Colors.grey.shade200);
                },
                itemCount: arguments.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTileWidget(index, arguments[index]);
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  _countClazz() {
    this.arguments.forEach((v) {
      _setMap.add(v.className);
    });
    return _setMap.length;
  }
}

///班级展示
class ListTileWidget extends StatelessWidget {
  int index = 0;
  SignDataClass _signDataClass;

  ListTileWidget(this.index, this._signDataClass);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text("${_signDataClass.className}"),
            color: index % 2 == 0 ? Colors.green.shade50 : Colors.white,
            alignment: Alignment.center,
            height: 50,
          ),
          flex: 2,
        ),
        Container(
          color: Colors.grey.shade200,
          width: 1,
          height: 50,
        ),
        Expanded(
          child: Container(
            child: Text("${_signDataClass.productName}"),
            color: index % 2 == 0 ? Colors.green.shade50 : Colors.white,
            alignment: Alignment.center,
            height: 50,
          ),
          flex: 3,
        )
      ],
    );
  }
}
