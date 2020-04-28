import 'package:flutter/material.dart';
import 'package:zsy/common/utils/toast_util.dart';
import 'package:zsy/routes/app_navigator.dart';
import 'package:zsy/routes/app_route.dart';

///@description:签名
///@author xcl qq:244672784
///@Date 2020/4/27 15:15
class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> with WidgetsBindingObserver {
  String args;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
        title: Text(
          "签字",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          WarningWidget(),
          ContentWidget("考试名称：", "直接展示学管端的产品1111111111111111列表的名称列表的名称"),
          ContentWidget("类型：", "考试类产品"),
          LineWidget(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5),
                  color: Colors.green,
                  width: 1,
                  height: 18,
                ),
                Expanded(child: Text("选择班级和产品")),
                GestureDetector(
                  child: Text(
                    "全选",
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () => ToastUtil.show("全选"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  children: _gridList(),
                )),
          ),
          LineWidget(),
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 200,
              color: Colors.grey,
              child: Text(
                "点击签名",
                style: TextStyle(color: Colors.green),
              ),
            ),
            onTap: () async => {
              AppNavigator.toPush(
                context,
                AppRoute.canvasPage,
              )
            },
          ),
          Container(
            height: 50,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: RaisedButton(
                elevation: 2.0,
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                  "确认上传",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async => ToastUtil.show("上传")),
          ),
        ],
      ),
    );
  }
}

///头部警告
class WarningWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/2.0x/ic_2x_warning.png",
            width: 14,
            height: 14,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "学管请根据线下实际情况请选择签名的产品和班级，如果假签，会追究商务职责",
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  ContentWidget(this.type, this.content);

  final type;
  final content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(type),
          Expanded(
            child: Text(content),
          ),
        ],
      ),
    );
  }
}

class LineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10,
      color: Colors.grey,
    );
  }
}

List<Widget> _gridList() {
  List<Widget> list = [];
  list.add(Stack(
    children: <Widget>[
      SizedBox(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text("三步金冠提分宝"), Text("高一(1班)")],
          ),
          onPressed: () => {ToastUtil.show("11111")},
        ),
      )
    ],
  ));
  return list;
}
