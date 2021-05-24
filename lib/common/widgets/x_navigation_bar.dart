import 'package:flutter/material.dart';

/// @description:底部选项卡
/// @author xcl qq:244672784
/// @Date 2021/5/23
class XNavigationBar extends StatefulWidget {
  //BottomAppBar选项 要搭配 FloatingActionButton
  final bool isBottomAppBar;

  //当前选中的Item
  final int currentIndex;

  //点击事件
  final ValueChanged<int> onTap;

  //背景色
  final Color color;

  //阴影
  final double elevation;

  //icon大小
  final double iconSize;

  //选中/不选中的Item颜色
  final Color unselectedItemColor;
  final Color selectedItemColor;

  //选中/不选中的字体大小
  final double selectedFontSize;
  final double unselectedFontSize;

  //选中/不选中的Icon样式
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;

  //选中/不选中的Text样式
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;

  ///*************BottomAppBar*****************///

  //悬浮按钮 与其他菜单栏的结合方式
  final NotchedShape shape;

  //裁剪方式
  final Clip clipBehavior;

  //FloatingActionButton和BottomAppBar之间的距离
  final double notchMargin;

  final List<Widget> appBarItems;

  ///*********************BottomNavigationBar****************///

  //显示所有（选中/不选中）的标签
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  //导航类型
  final BottomNavigationBarType type;

  //
  final Color fixedColor;

  final List<BottomNavigationBarItem> items;

  const XNavigationBar({
    Key key,
    this.isBottomAppBar = false,
    this.color,
    this.elevation = 2.0,
    this.shape = const CircularNotchedRectangle(),
    this.clipBehavior = Clip.none,
    this.notchMargin = 4.0,
    this.appBarItems,
    this.currentIndex = 0,
    this.onTap,
    this.iconSize = 24.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.type = BottomNavigationBarType.fixed,
    this.fixedColor,
    this.showUnselectedLabels,
    this.showSelectedLabels = true,
    this.items,
  }) : super(key: key);

  @override
  _XNavigationBarState createState() => _XNavigationBarState();
}

class _XNavigationBarState extends State<XNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return widget.isBottomAppBar
        ? _getBottomAppBar()
        : _getBottomNavigationBar();
  }

  Widget _getBottomAppBar() {
    return BottomAppBar(
      color: widget.color,
      shape: widget.shape,
      elevation: widget.elevation,
      notchMargin: widget.notchMargin,
      child: Row(
        children: widget.appBarItems,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }

  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      type: widget.type,
      fixedColor: widget.fixedColor,
      showUnselectedLabels: widget.showUnselectedLabels,
      showSelectedLabels: widget.showSelectedLabels,
      items: widget.items,
      elevation: widget.elevation,
      backgroundColor: widget.color,
      onTap: widget.onTap,
      iconSize: widget.iconSize,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
      selectedIconTheme: widget.selectedIconTheme,
      unselectedIconTheme: widget.unselectedIconTheme,
      selectedFontSize: widget.selectedFontSize,
      unselectedFontSize: widget.unselectedFontSize,
      selectedLabelStyle: widget.selectedLabelStyle,
      unselectedLabelStyle: widget.unselectedLabelStyle,
    );
  }
}
