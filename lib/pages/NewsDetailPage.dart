import 'package:flutter/material.dart';

/// 资讯详情界面
class NewsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "资讯详情",
          style: new TextStyle(color: Colors.white),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("资讯详情界面"),
            new RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text("返回"),
            )
          ],
        ),
      ),
    );
  }
}
