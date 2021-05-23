import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/common/utils/check_util.dart';
import 'package:flutter_project/common/widgets/buidler/clip_builder.dart';

/// @description:Img封装
/// @author xcl qq:244672784
/// @Date 2021/5/15 13:01
class XImg extends StatefulWidget {
  //路径
  final dynamic path;

  //类型
  final XImgType type;
  final AssetBundle assetBundle;

  //加载过程中添加动画
  final ImageFrameBuilder frameBuilder;

  //加载过程中展示一个Widget
  final ImageLoadingBuilder loadingBuilder;

  //描述
  final String semanticLabel;

  //是否去除语义描述
  final bool excludeFromSemantics;

  //缩放比例
  final double scale;

  //宽
  final double width;

  //高
  final double height;

  //混合颜色
  final Color color;

  //混合枚举类型
  final BlendMode colorBlendMode;

  //填充方式
  final BoxFit fit;

  //摆放位置
  final Alignment alignment;

  //重复填充方式 （当前图片没有完全覆盖Image设置区域，未覆盖的区域设置填充方式）
  final ImageRepeat repeat;

  //设置可拉伸区域  （.9path图片 拉伸区域）
  final Rect centerSlice;

  //内容显示方向  跟 TextDirection 效果一样  必须试用 Directionality 组件包裹Image 才生效
  final bool matchTextDirection;

  //当 ImageProvider 发生变化后，重新加载图片的过程中，原图片的展示是否保留
  final bool gaplessPlayback;

  //加载质量
  final FilterQuality filterQuality;

  //缓存
  final int cacheWidth;
  final int cacheHeight;

  //裁剪Builder
  final ClipBuilder clipBuilder;

  //请求头
  final Map<String, String> headers;

  //单击
  final GestureTapCallback onPressed;

  final String package;

  //长按
  final GestureLongPressCallback onLongPressed;

  XImg(
    this.path, {
    Key key,
    this.type = XImgType.asset,
    this.assetBundle,
    this.frameBuilder,
    this.loadingBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.scale = 1.0,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
    this.cacheHeight = -1,
    this.cacheWidth = -1,
    this.clipBuilder,
    this.headers,
    this.package,
    this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  @override
  _XImgState createState() => _XImgState();
}

class _XImgState extends State<XImg> {
  @override
  Widget build(BuildContext context) {
    return _getBuildWidget(CheckUtil.isObjNull(widget.clipBuilder)
        ? _getImgWidget()
        : _getClipWidget());
  }

  ///文件
  Image _getImageFile() {
    return Image.file(
      File(widget.path),
      width: widget.width,
      height: widget.height,
      cacheWidth: widget.cacheWidth,
      cacheHeight: widget.cacheHeight,
      scale: widget.scale,
      fit: widget.fit,
      filterQuality: widget.filterQuality,
      frameBuilder: widget.frameBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
    );
  }

  ///网络
  Image _getImageNetWork() {
    return Image.network(
      widget.path,
      width: widget.width,
      height: widget.height,
      cacheWidth: widget.cacheWidth,
      cacheHeight: widget.cacheHeight,
      scale: widget.scale,
      fit: widget.fit,
      filterQuality: widget.filterQuality,
      frameBuilder: widget.frameBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
      headers: widget.headers,
    );
  }

  ///本地
  Image _getImageAsset() {
    // return Image.asset(
    //   widget.path,
    //   width: widget.width,
    //   height: widget.height,
    //   cacheWidth: widget.cacheWidth,
    //   cacheHeight: widget.cacheHeight,
    //   scale: widget.scale,
    //   fit: widget.fit,
    //   filterQuality: widget.filterQuality,
    //   frameBuilder: widget.frameBuilder,
    //   semanticLabel: widget.semanticLabel,
    //   excludeFromSemantics: widget.excludeFromSemantics,
    //   color: widget.color,
    //   colorBlendMode: widget.colorBlendMode,
    //   alignment: widget.alignment,
    //   repeat: widget.repeat,
    //   centerSlice: widget.centerSlice,
    //   matchTextDirection: widget.matchTextDirection,
    //   gaplessPlayback: widget.gaplessPlayback,
    //   package: widget.package,
    // );

    return Image(
      image: widget.cacheHeight <= 0 || widget.cacheWidth <= 0
          ? AssetImage(widget.path,
              bundle: widget.assetBundle, package: widget.package)
          : ExactAssetImage(widget.path,
              scale: widget.scale,
              bundle: widget.assetBundle,
              package: widget.package),
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      filterQuality: widget.filterQuality,
      frameBuilder: widget.frameBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
    );
  }

  ///TODO  这玩意暂时玩不明白
  Image _getImageMemory() {
    return Image.memory(
      widget.path,
      width: widget.width,
      height: widget.height,
      cacheWidth: widget.cacheWidth,
      cacheHeight: widget.cacheHeight,
      scale: widget.scale,
      fit: widget.fit,
      filterQuality: widget.filterQuality,
      frameBuilder: widget.frameBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
    );
  }

  ///根据类型获取Image
  Widget _getImgWidget() {
    switch (widget.type) {
      case XImgType.file:
        return _getImageFile();
      case XImgType.asset:
        return _getImageAsset();
      case XImgType.netWork:
        return _getImageNetWork();
      case XImgType.memory:
        return _getImageMemory();
      default:
        return _getImageNetWork();
    }
  }

  ///根据类型裁剪
  Widget _getClipWidget() {
    switch (widget.clipBuilder.clipType) {
      case ClipType.oval:
        return ClipOval(
          child: _getImgWidget(),
          clipBehavior: widget.clipBuilder.clipBehavior,
          clipper: widget.clipBuilder.clipper,
        );
      case ClipType.rect:
        return ClipRect(
          child: _getImgWidget(),
          clipBehavior: widget.clipBuilder.clipBehavior,
          clipper: widget.clipBuilder.clipper,
        );
      case ClipType.rRect:
        return ClipRRect(
          child: _getImgWidget(),
          clipBehavior: widget.clipBuilder.clipBehavior,
          borderRadius: widget.clipBuilder.borderRadius,
        );
      case ClipType.path:
        return ClipPath(
          child: _getImgWidget(),
          clipBehavior: widget.clipBuilder.clipBehavior,
        );
    }
  }

  Widget _getBuildWidget(Widget childWidget) {
    return CheckUtil.isObjNull(widget.onPressed) &&
            CheckUtil.isObjNull(widget.onLongPressed)
        ? childWidget
        : GestureDetector(
            child: childWidget,
            onTap: widget.onPressed,
            onLongPress: widget.onLongPressed,
          );
  }
}

///枚举
enum XImgType {
  file,
  asset,
  netWork,
  memory,
}
