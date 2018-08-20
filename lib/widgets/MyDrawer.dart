import 'package:flutter/material.dart';

/// 侧滑布局页面
// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  /// 侧滑菜单的宽度
  static const double DRAWER_WIDTH = 304.0;

  /// 菜单文本前面的图标大小
  static const double IMAGE_ICON_WIDTH = 30.0;

  /// 菜单后面的箭头的图标大小
  static const double ARROW_ICON_WIDTH = 16.0;

  /// 菜单后面的箭头
  var rightArrowIcon = new Image.asset(
    "images/ic_arrow_right.png",
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  /// 菜单的文本数组
  var menuTitles = ['发布动弹', '动弹小黑屋', '关于', '设置'];

  /// 菜单文本前的图片
  var menuIcons = [
    './images/leftmenu/ic_fabu.png',
    './images/leftmenu/ic_xiaoheiwu.png',
    './images/leftmenu/ic_about.png',
    './images/leftmenu/ic_settings.png'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ConstrainedBox(
      // 指定侧滑菜单的宽度
      constraints: const BoxConstraints.expand(width: DRAWER_WIDTH),
      child: new Material(
        elevation: 16.0, // 控制Drawer后面的阴影的大小，默认值就是16,此处可不设置
        child: new Container(
          decoration: new BoxDecoration(
            color: const Color(0xFFFFFFFF),
          ),
          child: new ListView.builder(
            itemBuilder: renderRow,
            // 这里之所以是menuTitles.length * 2 + 1，其中的*2是将分割线算入到item中了，+1则是把顶部的封面图算入到item中了
            itemCount: menuTitles.length * 2 + 1,
          ),
        ),
      ),
    );
  }

  /// 渲染Item布局
  Widget renderRow(BuildContext context, int index) {
    if (index == 0) {
      // 设置头部的背景图
      var image = new Image.asset('images/cover_img.jpg',
          width: DRAWER_WIDTH, height: DRAWER_WIDTH);
      return new Container(
          width: DRAWER_WIDTH,
          height: DRAWER_WIDTH,
          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0), // 设置下边距为10
          child: image);
    }

    // 舍去头布局
    index -= 1;
    // 如果是奇数则渲染分割线
    if (index.isOdd) {
      return new Divider();
    }
    // 偶数，就除2取整，渲染Item项
    index = index ~/ 2;
    // 菜单Item项
    var listItem = new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: new Row(
        children: <Widget>[
          // 菜单Item的图标
          getIconImage(menuIcons[index]),
          // 菜单Item的文本；Expanded组件类似于weight=1
          new Expanded(
              child: new Text(menuTitles[index],
                  style: new TextStyle(fontSize: 15.0))),
          rightArrowIcon
        ],
      ),
    );

    return new InkWell(
      child: listItem,
      onTap: () {
        print("你点击了第$index项");
      },
    );
  }

  /// 获取菜单项右侧的图标
  getIconImage(String menuIconPath) {
    return new Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 0.0, 6.0, 0.0),
        child: new Image.asset(menuIconPath, width: 28.0, height: 28.0));
  }
}
