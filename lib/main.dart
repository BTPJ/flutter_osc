import 'package:flutter/material.dart';
import 'package:flutter_osc/pages/DiscoveryPage.dart';
import 'package:flutter_osc/pages/MyInfoPage.dart';
import 'package:flutter_osc/pages/NewsListPage.dart';
import 'package:flutter_osc/pages/TweetsListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_osc/widgets/MyDrawer.dart';

void main() => runApp(new MyApp());

/// 主界面
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyOSCClientState();
  }
}

class MyOSCClientState extends State<MyApp> {
  /// 页面当前选中的Tab的索引
  int currentTabIndex = 0;

  /// 页面底部TabItem上的图标数组
  var tabImages;

  /// 页面顶部的大标题（也是TabItem上的文本）
  var appBarTitles = ['资讯', '动弹', '发现', '我的'];

  /// tab未选中字体的样式
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));

  /// tab选中后字体的样式
  final tabTextStyleSelected = new TextStyle(color: const Color(0xff63ca6c));

  var body;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    initData(); // 初始化各种数据，包括TabIcon数据和页面内容数据
    return new MaterialApp(
      theme: new ThemeData(
          // 设置主题色
          primaryColor: const Color(0xFF63CA6C)),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("My OSC", style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: body,

        // bottomNavigationBar属性为页面底部添加导航的Tab，CupertinoTabBar是Flutter提供的一个iOS风格的底部导航栏组件
        bottomNavigationBar: new CupertinoTabBar(
          items: getBottomNavItems(),
          onTap: (index) {
            setState(() {
              currentTabIndex = index;
            });
          },
        ),

        //  drawer属性用于为当前页面添加一个侧滑菜单
        drawer: new MyDrawer(),
      ),
    );
  }

  /// 数据初始化，包括TabIcon数据和页面内容数据
  void initData() {
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/ic_nav_news_normal.png'),
          getTabImage('images/ic_nav_news_actived.png')
        ],
        [
          getTabImage('images/ic_nav_tweet_normal.png'),
          getTabImage('images/ic_nav_tweet_actived.png')
        ],
        [
          getTabImage('images/ic_nav_discover_normal.png'),
          getTabImage('images/ic_nav_discover_actived.png')
        ],
        [
          getTabImage('images/ic_nav_my_normal.png'),
          getTabImage('images/ic_nav_my_pressed.png')
        ]
      ];
    }

    /// 页面body部分组件
    body = new IndexedStack(
      children: <Widget>[
        new NewsListPage(),
        new TweetsListPage(),
        new DiscoveryPage(),
        new MyInfoPage()
      ],
      index: currentTabIndex,
    );
  }

  /// 传入图片路径，返回一个Image组件
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  /// 获得底部Tab对应的Item
  List<BottomNavigationBarItem> getBottomNavItems() {
    List<BottomNavigationBarItem> list = new List();
    for (int i = 0; i < 4; i++) {
      list.add(new BottomNavigationBarItem(
          icon: getTabIcon(i), title: getTabTitle(i)));
    }
    return list;
  }

  /// 根据当前的tabIndex获取Tab显示的图标
  Image getTabIcon(int tabIndex) {
    if (tabIndex == currentTabIndex) {
      return tabImages[currentTabIndex][1];
    }
    return tabImages[tabIndex][0];
  }

  /// 根据当前的tabIndex获取Tab显示的标题
  Text getTabTitle(int tabIndex) {
    return new Text(
      appBarTitles[tabIndex],
      style: getTabTextStyle(tabIndex),
    );
  }

  /// 根据当前的tabIndex获取Tab字体的样式
  TextStyle getTabTextStyle(int tabIndex) {
    if (tabIndex == currentTabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }
}
