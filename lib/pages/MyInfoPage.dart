import 'package:flutter/material.dart';

/// 我的Tab界面
// ignore: must_be_immutable
class MyInfoPage extends StatelessWidget {
  var titles = ["我的消息", "阅读记录", "我的博客", "我的问答", "我的活动", "我的团队", "邀请好友"];
  var imagePaths = [
    "images/ic_my_message.png",
    "images/ic_my_blog.png",
    "images/ic_my_blog.png",
    "images/ic_my_question.png",
    "images/ic_discover_pos.png",
    "images/ic_my_team.png",
    "images/ic_my_recommend.png"
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: (context, i) => renderRow(i),
        itemCount: titles.length * 2);
  }

  /// 渲染Item布局
  renderRow(int i) {
    if (i == 0) {
      return new Container(
        color: const Color(0xff63ca6c),
        height: 200.0,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                "images/ic_avatar_default.png",
                width: 60.0,
              ),
              new Text("点击头像登录",
                  style: new TextStyle(color: Colors.white, fontSize: 16.0))
            ],
          ),
        ),
      );
    }

    i -= 1;
    if (i.isOdd) {
      return new Divider(
        height: 1.0,
      );
    }

    i = i ~/ 2;
    var listItemContent = new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: new Image.asset(
              imagePaths[i],
              width: 30.0,
              height: 30.0,
            ),
          ),
          new Expanded(
              child: new Text(
            titles[i],
            style: new TextStyle(fontSize: 16.0),
          )),
          new Image.asset('images/ic_arrow_right.png',
              width: 16.0, height: 16.0)
        ],
      ),
    );

    return new InkWell(
      child: listItemContent,
      onTap: () {
        handleListItemClick(titles[i]);
      },
    );
  }

  /// item点击事件
  void handleListItemClick(String title) {
    switch (title) {
      case "我的消息":
        print("点击我的消息");
        break;
      case "阅读记录":
        print("点击阅读记录");
        break;
      case "我的博客":
        print("点击我的博客");
        break;
      case "我的问答":
        print("点击我的问答");
        break;
      case "我的活动":
        print("点击我的活动");
        break;
      case "我的团队":
        print("我的团队");
        break;
      case "邀请好友":
        print("邀请好友");
        break;
    }
  }
}
