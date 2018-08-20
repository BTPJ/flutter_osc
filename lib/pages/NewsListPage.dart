import 'package:flutter/material.dart';
import 'package:flutter_osc/widgets/SlideView.dart';

/// 资讯列表Tab界面
// ignore: must_be_immutable
class NewsListPage extends StatelessWidget {
  /// 轮播图的数据
  var slideData = [];

  /// 列表的数据（轮播图数据和列表数据分开，但是实际上轮播图和列表中的item同属于ListView的item）
  var listData = [];

  NewsListPage() {
    // 测试轮播图数据
    for (var i = 0; i < 3; i++) {
      Map map = new Map();
      map['title'] = 'Python 之父透露退位隐情，与核心开发团队产生隔阂';
      map['detailUrl'] =
          'https://www.oschina.net/news/98455/guido-van-rossum-resigns';
      map['imgUrl'] =
          'https://static.oschina.net/uploads/img/201807/30113144_1SRR.png';
      slideData.add(map);
    }

    // 测试列表数据
    for (var j = 0; j < 30; j++) {
      Map map = new Map();
      map['title'] = 'J2Cache 2.3.23 发布，支持 memcached 二级缓存';
      // 列表item的作者头像URL
      map['authorImg'] =
          'https://static.oschina.net/uploads/user/0/12_50.jpg?t=1421200584000';
      // 列表item的时间文本
      map['timeStr'] = '2018-7-30';
      // 列表item的资讯图片
      map['thumb'] =
          'https://static.oschina.net/uploads/logo/j2cache_N3NcX.png';
      // 列表item的评论数
      map['commCount'] = j;
      listData.add(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, index) => renderRow(index),
      itemCount: listData.length * 2 + 1,
    );
  }

  /// 渲染列表项
  renderRow(int index) {
    // 第一项为轮播图
    if (index == 0) {
      return new Container(
        height: 180.0,
        child: new SlideView(slideData),
      );
    }

    index -= 1;
    if (index.isOdd) {
      // 奇数表示分割线
      return new Divider(
        height: 1.0,
      );
    }

    index = index ~/ 2; // 取整
    var itemData = listData[index];
    // 代表列表item中的标题这一行
    var titleRow = new Row(
      children: <Widget>[
        // 标题充满一整行，所以用Expanded组件包裹
        new Expanded(
            child: new Text(
          itemData['title'],
          style: new TextStyle(fontSize: 15.0),
        ))
      ],
    );

    var timeRow = new Row(
      children: <Widget>[
        // 作者头像
        new Container(
          width: 20.0,
          height: 20.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFECECEC),
              image: new DecorationImage(
                  image: new NetworkImage(itemData['authorImg']),
                  fit: BoxFit.cover),
              border:
                  new Border.all(color: const Color(0xFFECECEC), width: 2.0)),
        ),

        // 日期
        new Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
          child: new Text(
            itemData['timeStr'],
            style: new TextStyle(color: Color(0xFFB5BDC0), fontSize: 12.0),
          ),
        ),

        // 评论数
        new Expanded(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Text(
              "${itemData['commCount']}",
              style: new TextStyle(color: Color(0xFFB5BDC0), fontSize: 12.0),
            ),
            new Image.asset(
              './images/ic_comment.png',
              width: 16.0,
              height: 16.0,
            )
          ],
        )),
      ],
    );

    // 右侧资讯
    var thumbImgUrl = itemData['thumb'];
    var thumbImg = new Container(
      margin: const EdgeInsets.all(10.0),
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
//              image: new ExactAssetImage('./images/ic_img_default.jpg'),
              image: new NetworkImage(thumbImgUrl),
              fit: BoxFit.cover),
          border: new Border.all(color: const Color(0xFFECECEC), width: 2.0)),
    );

    // item的row
    var itemRow = new Row(
      children: <Widget>[
        // 左侧是标题时间等
        new Expanded(
            child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              titleRow,
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: timeRow,
              ),
            ],
          ),
        )),
        new Padding(
          padding: const EdgeInsets.all(6.0),
          child: new Container(
            width: 100.0,
            height: 80.0,
            color: const Color(0xFFECECEC),
            child: new Center(
              child: thumbImg,
            ),
          ),
        )
      ],
    );

    return new InkWell(
      child: itemRow,
      onTap: () {
        //TODO item 点击事件
        print("点击第$index项");
      },
    );
  }
}
