import 'package:flutter/material.dart';
import 'package:flutter_project/common/utils/check_util.dart';
import 'package:flutter_project/common/widgets/x_img.dart';
import 'package:flutter_project/common/widgets/x_text.dart';

/// @description:
/// @author xcl qq:244672784
/// @Date 2021/5/15 13:03
class XAppBar extends StatefulWidget {
  //左边Widget
  final Widget leading;

  //如果leading为null，是否自动实现默认的leading按钮
  final bool automaticallyImplyLeading;

  //标题Widget
  final Widget title;

  //默认标题XText
  final String titleStr;

  //右边Widget
  final List<Widget> actions;

  //实现一些特殊的效果，该属性通常在 SliverAppBar 中使用，类似于Android中的CollapsingToolbarLayout，可以轻松实现页面头部展开、合并的效果
  final Widget flexibleSpace;

  //通常是 TabBar,用来在 Toolbar 标题下面显示一个 Tab 导航栏。
  final PreferredSizeWidget bottom;

  //控制阴影大小
  final double elevation;
  final ShapeBorder shape;
  final Color backgroundColor;

  //亮度 有黑白两种主题
  final Brightness brightness;

  //左边图标的样式
  final IconThemeData iconTheme;

  //右边图标样式
  final IconThemeData actionsIconTheme;

  //文本样式
  final TextTheme textTheme;

  //如果为false，会沉浸在状态栏下centerTitle
  final bool primary;

  //标题是否居中
  final bool centerTitle;

  //标题间距
  final double titleSpacing;

  //状态栏是否透明
  final double toolbarOpacity;

  //底部TabBar 是否透明
  final double bottomOpacity;

  ///根据自己项目 重写这边逻辑
  //默认左边XImg
  final String leadingPath;

  //默认左边XImg 点击事件
  final GestureTapCallback onLeadingPressed;

  //默认菜单
  final Widget actionMenu;

  //默认菜单边上的 Icon Path
  final String actionIconPath;

  //默认菜单边上的 Icon 点击事件
  final GestureTapCallback onActionIconPressed;

  const XAppBar({
    Key key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 4,
    this.shape,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle = true,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.leadingPath,
    this.titleStr,
    this.actionIconPath,
    this.actionMenu,
    this.onLeadingPressed,
    this.onActionIconPressed,
  }) : super(key: key);

  @override
  _XAppBarState createState() => _XAppBarState();
}

class _XAppBarState extends State<XAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _getLeading(context),
      title: _getTitle(),
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      actions: _getActions(),
      flexibleSpace: widget.flexibleSpace,
      bottom: _getBottom(),
      elevation: widget.elevation,
      shape: widget.shape,
      backgroundColor: widget.backgroundColor,
      brightness: widget.brightness,
      iconTheme: widget.iconTheme,
      actionsIconTheme: widget.actionsIconTheme,
      textTheme: widget.textTheme,
      primary: widget.primary,
      centerTitle: widget.centerTitle,
      titleSpacing: widget.titleSpacing,
      toolbarOpacity: widget.toolbarOpacity,
      bottomOpacity: widget.bottomOpacity,
    );
  }

  ///Leading
  Widget _getLeading(BuildContext context) {
    return !CheckUtil.isStrEmpty(widget.leadingPath)
        ? XImg(widget.leadingPath,
            onPressed: CheckUtil.isObjNull(widget.onLeadingPressed)
                ? () => Navigator.maybePop(context)
                : widget.onLeadingPressed)
        : widget.leading;
  }

  ///Title
  Widget _getTitle() {
    return !CheckUtil.isStrEmpty(widget.titleStr)
        ? XText(widget.titleStr)
        : widget.title;
  }

  ///Actions
  List<Widget> _getActions() {
    List actions = [];
    if (!CheckUtil.isObjNull(widget.actionMenu)) {
      actions.add(widget.actionMenu);
    }
    if (!CheckUtil.isStrEmpty(widget.actionIconPath)) {
      actions.add(
          XImg(widget.actionIconPath, onPressed: widget.onActionIconPressed));
    }
    return CheckUtil.isListEmpty(widget.actions) ? actions : widget.actions;
  }

  ///TODO
  Widget _getBottom() {
    return Container();
  }
}
