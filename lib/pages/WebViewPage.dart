import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// 通用的webView界面
// ignore: must_be_immutable
class WebViewPage extends StatefulWidget {
  /// 标题
  String title;

  /// url
  String url;

  WebViewPage({Key key, this.title, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  bool loading = true;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen((url) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> titleContent = [];
    titleContent.add(new Text(
      widget.title,
      style: new TextStyle(color: Colors.white),
    ));
    if (loading) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Container(
      width: 50.0,
    ));
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
