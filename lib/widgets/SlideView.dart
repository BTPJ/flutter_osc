import 'package:flutter/material.dart';

/// 轮播图组件
class SlideView extends StatefulWidget {
  /// 轮播图中的数据
  var data;

  /// 构造（data表示轮播图中的数据）
  SlideView(data) {
    this.data = data;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    // 可以在构造方法中传参供SlideViewState使用
    // 或者也可以不传参数，直接在SlideViewState中通过this.widget.data访问SlideView中的data变量
    return new SlideViewState(data);
  }
}

class SlideViewState extends State<SlideView>
    with SingleTickerProviderStateMixin<SlideView> {
  /// TabBarView组件的控制器
  TabController tabController;
  List slideData;

  SlideViewState(data) {
    this.slideData = data;
  }

  @override
  void initState() {
    // TODO: 初始化状态
    super.initState();
    tabController = new TabController(
        length: slideData == null ? 0 : slideData.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> items = [];
    if (slideData != null && slideData.length > 0) {
      for (var i = 0; i < slideData.length; i++) {
        var item = slideData[i];
        var imgUrl = item['imgUrl']; // 图片URL
        var title = item['title']; // 资讯标题
        var detailUrl = item['detailUrl']; // 资讯详情Url
        items.add(new GestureDetector(
          onTap: () {
            // 点击轮播图跳到相应的详情界面
          },
          child: new Stack(
            children: <Widget>[
              new Image.network(imgUrl),
              new Container(
                width: MediaQuery.of(context).size.width, // 标题容器宽度跟屏幕宽度一致
                color: const Color(0x50000000), // 背景为黑色，加入透明度
                child: new Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: new Text(
                    title,
                    style: new TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              )
            ],
          ),
        ));
      }
    }
    return new TabBarView(children: items, controller: tabController);
  }

  @override
  void dispose() {
    // TODO: 对象的销毁
    tabController.dispose();
    super.dispose();
  }
}
