import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osc/pages/WebViewPage.dart';

/// 发现Tab界面
// ignore: must_be_immutable
class DiscoveryPage extends StatelessWidget {
  /// 完整的分隔线（开始和结尾）
  static const String COMPLETE_LINE = "completeLine";

  /// 左侧有间距的分隔线（中间）
  static const String PADDING_LINE = "paddingLine";

  /// 空白区域
  static const String BLANK = "blank";

  final imagePaths = [
    "images/ic_discover_softwares.png",
    "images/ic_discover_git.png",
    "images/ic_discover_gist.png",
    "images/ic_discover_scan.png",
    "images/ic_discover_shake.png",
    "images/ic_discover_nearby.png",
    "images/ic_discover_pos.png",
  ];

  final titles = ["开源软件", "码云推荐", "代码片段", "扫一扫", "摇一摇", "码云封面人物", "线下活动"];

  var listData = [];

  /// 构造器
  DiscoveryPage() {
    initData(); // 初始化数据
  }

  /// 数据初始化
  void initData() {
    listData.add(COMPLETE_LINE);
    // 开始三行
    for (int i = 0; i < 3; i++) {
      listData.add(new ListItem(imagePaths[i], titles[i]));
      if (i == 2) {
        listData.add(COMPLETE_LINE);
      } else {
        listData.add(PADDING_LINE);
      }
    }

    listData.add(BLANK);
    listData.add(COMPLETE_LINE);
    // 中间两行
    for (int i = 3; i < 5; i++) {
      listData.add(new ListItem(imagePaths[i], titles[i]));
      if (i == 4) {
        listData.add(COMPLETE_LINE);
      } else {
        listData.add(PADDING_LINE);
      }
    }

    // 最后两行
    for (int i = 5; i < 7; i++) {
      listData.add(new ListItem(imagePaths[i], titles[i]));
      if (i == 6) {
        listData.add(COMPLETE_LINE);
      } else {
        listData.add(PADDING_LINE);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: new ListView.builder(
            itemBuilder: (context, index) => renderRow(context, index),
            itemCount: listData.length));
  }

  /// 渲染Item
  renderRow(BuildContext context, int index) {
    var item = listData[index];
    if (item is String) {
      switch (item) {
        case COMPLETE_LINE:
          return new Divider(height: 1.0);
          break;
        case PADDING_LINE:
          return new Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
            child: new Divider(
              height: 1.0,
            ),
          );
          break;
        case BLANK:
          return new Container(
            height: 20.0,
          );
          break;
      }
    } else if (item is ListItem) {
      var listItemContent = new Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: new Row(
          children: <Widget>[
            // 左侧图片
            new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: new Image.asset(
                  item.icon,
                  width: 30.0,
                  height: 30.0,
                )),

            // 中间title
            new Expanded(
                child:
                    new Text(item.title, style: new TextStyle(fontSize: 16.0))),

            // 右侧箭头
            new Image.asset('images/ic_arrow_right.png',
                height: 16.0, width: 16.0)
          ],
        ),
      );
      return new InkWell(
          child: listItemContent,
          onTap: () {
            handleListItemClick(context, item);
          });
    }
  }

  /// item点击事件
  void handleListItemClick(BuildContext context, ListItem item) {
    String title = item.title;
    switch (title) {
      case "开源软件":
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(
              title: "开源软件", url: "https://m.gitee.com/explore");
        }));
        break;
      case "码云推荐":
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(
              title: "码云推荐", url: "https://m.gitee.com/explore");
        }));
        break;
      case "代码片段":
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(
              title: "代码片段", url: "https://m.gitee.com/gists");
        }));
        break;
      case "扫一扫":
        scan();
        break;
      case "摇一摇":
        print("点击摇一摇");
        Scaffold
            .of(context)
            .showSnackBar(new SnackBar(content: new Text("点击摇一摇")));
        break;
      case "码云封面人物":
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(
              title: "码云封面人物", url: "https://m.gitee.com/gitee-stars/");
        }));
        break;
      case "线下活动":
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(
              title: "线下活动", url: "https://m.gitee.com/gists");
        }));
        break;
    }
  }

  /// 扫码
  Future scan() async {
    try {
      String barCode = await BarcodeScanner.scan();
      print(barCode);
    } on Exception catch (e) {
      print(e);
    }
  }
}

/// Item数据
class ListItem {
  String icon;
  String title;

  ListItem(this.icon, this.title);
}
