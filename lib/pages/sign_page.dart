import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/common/image_file.dart';
import 'package:flutter_project/common/net/net_request.dart';
import 'package:flutter_project/common/res/res_colors.dart';
import 'package:flutter_project/common/utils/check_util.dart';
import 'package:flutter_project/common/utils/toast_util.dart';
import 'package:flutter_project/entity/raw_content_entity.dart';
import 'package:flutter_project/entity/sign_entity.dart';
import 'package:flutter_project/routes/app_navigator.dart';
import 'package:flutter_project/routes/app_route.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

///@description:签名
///@author xcl qq:244672784
///@Date 2020/4/27 15:15
class SignPage extends StatefulWidget {
  final arguments;

  SignPage({this.arguments});

  @override
  _SignPageState createState() => _SignPageState(arguments: this.arguments);
}

class _SignPageState extends State<SignPage> {
  RawContentEntity arguments;
  SignEntity _signEntity;
  SignData _signData;
  Map<String, SignDataClass> _clazzMap;
  Map<String, SignDataClass> _signMap;

  bool _isAllChecked = false;
  bool _isShowLoading = true;
  bool _isShowNetStatus = false;
  bool _isNetEmpty = true;

  String _signPath = "";

  _SignPageState({this.arguments});

  @override
  void initState() {
    super.initState();
    _clazzMap = Map();
    _signMap = Map();
    try {
      if (CheckUtil.isObjNull(arguments)) {
        ToastUtil.show("非法扫描，不能识别的二维码");
        setState(() {
          _isShowNetStatus = true;
          _isNetEmpty = true;
          _isShowLoading = false;
        });
        return;
      }
      _getProductDetail(arguments.type, arguments.id, false);
    } catch (e) {
      ToastUtil.show("非法扫描，不能识别的二维码");
      setState(() {
        _isShowNetStatus = true;
        _isShowLoading = false;
        _isNetEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: RefreshIndicator(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView(
                children: CheckUtil.isObjNull(_signEntity)
                    ? <Widget>[]
                    : <Widget>[
                        WarningWidget(),
                        ContentWidget(
                            "名称：",
                            CheckUtil.isObjNull(this._signEntity)
                                ? ""
                                : this._signEntity.data.name),
                        ContentWidget(
                            "类型：",
                            CheckUtil.isObjNull(this._signEntity)
                                ? ""
                                : CheckUtil.isStrNull(
                                        this._signEntity.data.typeName)
                                    ? ""
                                    : this._signEntity.data.typeName),
                        LineWidget(),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                color: ResColors.greenColor,
                                width: 1,
                                height: 18,
                              ),
                              Expanded(child: Text("选择班级和产品")),
                              GestureDetector(
                                child: Text(
                                  !_isAllChecked ? "全选" : "取消全选",
                                  style: TextStyle(color: ResColors.greenColor),
                                ),
                                onTap: () {
                                  if (_isAllChecked) {
                                    if (_clazzMap.isNotEmpty) {
                                      _clazzMap.clear();
                                      setState(() {
                                        _clazzMap = _clazzMap;
                                        _isAllChecked = false;
                                      });
                                    }
                                    return;
                                  }
                                  if (!CheckUtil.isListEmpty(
                                      this._signEntity.data.classes)) {
                                    this
                                        ._signEntity
                                        .data
                                        .classes
                                        .forEach((v) => {
                                              if (v.isSigned != 1)
                                                {
                                                  _isAllChecked = true,
                                                  _clazzMap[v.classId +
                                                      "${v.productType}"] = v
                                                }
                                            });
                                    setState(() {
                                      _clazzMap = _clazzMap;
                                      _isAllChecked = _isAllChecked;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GridView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 2.8),
                            children: CheckUtil.isObjNull(
                                        this._signEntity) ||
                                    CheckUtil.isListEmpty(
                                        this._signEntity.data.classes)
                                ? <Widget>[]
                                : this._signEntity.data.classes.map((item) {
                                    String key =
                                        "${item.classId}${item.productType}";
                                    return Stack(
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: RaisedButton(
                                              color: !CheckUtil.isObjNull(
                                                      _signMap[key])
                                                  ? Colors.grey.shade300
                                                  : !CheckUtil.isObjNull(
                                                          _clazzMap[key])
                                                      ? ResColors.greenColor
                                                      : Colors.white,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    item.productName,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: !CheckUtil
                                                              .isObjNull(
                                                                  _clazzMap[
                                                                      key])
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    item.className,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: !CheckUtil
                                                              .isObjNull(
                                                                  _clazzMap[
                                                                      key])
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              onPressed: () {
                                                if (!CheckUtil.isObjNull(
                                                    _signMap[key])) return;
                                                if (CheckUtil.isObjNull(
                                                    _clazzMap[key])) {
                                                  _clazzMap[key] = item;
                                                } else {
                                                  _clazzMap.remove(key);
                                                }
                                                setState(() {
                                                  _clazzMap = _clazzMap;
                                                });
                                              }),
                                        ),
                                        Align(
                                          child: Offstage(
                                            child: Image(
                                              image: AssetImage(
                                                  "images/ic_checked.png"),
                                            ),
                                            offstage: CheckUtil.isObjNull(
                                                _clazzMap[key]),
                                          ),
                                          alignment: Alignment.bottomRight,
                                        )
                                      ],
                                    );
                                  }).toList(),
                          ),
                        ),
                        LineWidget(),
                        GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              width: double.infinity,
                              height: 200,
                              color: Colors.white,
                              child: CheckUtil.isStrNull(_signPath)
                                  ? Text("点击签名")
                                  : Image(image: ImageFile(File(_signPath)))),
                          onTap: () {
                            _signData = SignData();
                            _signData.classes = _clazzMap.values.toList();
                            _signData.name = this._signEntity.data.name;
                            AppNavigator.toPushThen(
                                    context, AppRoute.CANVAS_PAGE,
                                    arguments: _signData)
                                .then((value) {
                              debugPrint(value);
                              setState(() {
                                _signPath = value;
                              });
                            });
                          },
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.all(20),
                          width: double.infinity,
                          child: RaisedButton(
                              elevation: 2.0,
                              color: CheckUtil.isStrNull(_signPath)
                                  ? Colors.grey.shade300
                                  : ResColors.greenColor,
                              textColor: Colors.white,
                              child: Text(
                                "确认上传",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                _saveSignData(
                                    _signEntity.data.name,
                                    arguments.id,
                                    _signEntity.data.grade,
                                    _clazzMap,
                                    _signPath);
                              }),
                        ),
                      ],
              ),
              Offstage(
                  offstage: !_isShowLoading,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Loading(
                      color: Colors.black38,
                      indicator: BallSpinFadeLoaderIndicator(),
                    ),
                  )),
              Offstage(
                  offstage: !_isShowNetStatus,
                  child: GestureDetector(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image(
                              image: AssetImage(_isNetEmpty
                                  ? "images/ic_net_empty.png"
                                  : "images/ic_net_error.png")),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            _isNetEmpty ? "暂无数据,请返回重新操作" : "网络请求失败，请返回重新操作",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          )
                        ],
                      ),
                      onTap: () {
                        _getProductDetail(arguments.type, arguments.id, false);
                      })),
            ],
          ),
          onRefresh: () async {
            Future.delayed(Duration(seconds: 5), () {
              return _getProductDetail(arguments.type, arguments.id, true);
            });
          }),
    );
  }

  ///获取产品信息
  _getProductDetail(String type, String id, bool isRefresh) async {
    if (CheckUtil.isStrNull(type) || CheckUtil.isStrNull(id)) {
      ToastUtil.show("参数不能为空");
      return null;
    }
    setState(() {
      _isShowLoading = isRefresh ? false : true;
      _isShowNetStatus = false;
    });
    SignEntity signEntity = await NetRequest.getProductDetail(type, id);
    if (CheckUtil.isObjNull(signEntity)) {
      ToastUtil.show("网络异常,请求失败");
      setState(() {
        _isNetEmpty = false;
        _isShowLoading = false;
        _isShowNetStatus = isRefresh ? false : true;
      });
      return;
    }
    if (signEntity.success != 1) {
      setState(() {
        _isNetEmpty = true;
        _isShowLoading = false;
        _isShowNetStatus = isRefresh ? false : true;
      });
      ToastUtil.show(signEntity.message);
      return;
    }
    //默认选中班级
    var signData = signEntity.data;
    if (!CheckUtil.isObjNull(signData) &&
        !CheckUtil.isListEmpty(signData.classes)) {
      signData.classes.forEach((v) => {
            if (arguments.classId == v.classId && v.isSigned == 0)
              {_clazzMap["${v.classId}${v.productType}"] = v},
            if (v.isSigned == 1) {_signMap["${v.classId}${v.productType}"] = v}
          });
    }
    setState(() {
      _signEntity = signEntity;
      _isShowLoading = false;
      _isShowNetStatus = false;
    });
  }

  ///保存签名信息
  _saveSignData(String name, String id, String grade,
      Map<String, SignDataClass> clazzMap, String signPath) async {
    if (CheckUtil.isStrNull(_signPath)) {
      ToastUtil.show("缺少产品/考试名称");
      return;
    }
    if (CheckUtil.isStrNull(arguments.id)) {
      ToastUtil.show("缺少Id");
      return;
    }
    if (CheckUtil.isStrNull(_signPath)) {
      ToastUtil.show("缺少年级");
      return;
    }
    if (_clazzMap == null || _clazzMap.length <= 0) {
      ToastUtil.show("缺少班级");
      return;
    }
    if (CheckUtil.isStrNull(_signPath)) {
      ToastUtil.show("缺少签名文件");
      return;
    }
    setState(() {
      _isShowLoading = true;
    });
    List<SignDataClass> cls = _clazzMap.values.toList();
    Response response =
        await NetRequest.saveSignData(name, id, grade, cls, signPath);
    if (response == null) {
      ToastUtil.show("上传失败");
      setState(() {
        _isShowLoading = false;
      });
    }
    if (response.data["success"] != 1) {
      ToastUtil.show(response.data["message"]);
      setState(() {
        _isShowLoading = false;
      });
      return;
    }
    ToastUtil.show("上传成功");
    setState(() {
      _isShowLoading = false;
    });
    AppNavigator.toPush(context, AppRoute.SIGN_SUCCESS_PAGE, arguments: cls);
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
          Image(
            image: AssetImage("images/ic_warning.png"),
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
