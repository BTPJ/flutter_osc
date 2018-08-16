import 'package:flutter/material.dart';
import 'package:flutter_osc/pages/NewsDetailPage.dart';

/// 资讯列表Tab界面
class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new RaisedButton(
      onPressed: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          return new NewsDetailPage();
        }));
      },
      child: new Text("跳转到详情界面"),
    ));
  }
}
