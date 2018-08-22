import 'package:flutter/material.dart';

/// 动弹Tab界面
// ignore: must_be_immutable
class TweetsListPage extends StatelessWidget {
  /// 普通动弹数据
  var normalTweetsList = [];

  /// 热门动弹数据
  var hotTweetsList = [];

  /// 屏幕宽度
  double screenWidth;

  /// 动弹作者文本样式
  TextStyle authorTextStyle;

  /// 动弹时间文本样式
  TextStyle subtitleStyle;

  /// 构造器，做一些初始化操作
  TweetsListPage() {
    authorTextStyle =
        new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);
    subtitleStyle =
        new TextStyle(fontSize: 12.0, color: const Color(0xFFB5BDC0));
    // 添加测试数据
    for (int i = 0; i < 20; i++) {
      Map<String, dynamic> map = new Map();
      map['pubDate'] = '2018-7-30';
      map['body'] =
          '早上七点十分起床，四十出门，花二十多分钟到公司，必须在八点半之前打卡；下午一点上班到六点，然后加班两个小时；八点左右离开公司，呼呼登自行车到健身房锻炼一个多小时。到家已经十点多，然后准备第二天的午饭，接着收拾厨房，然后洗澡，吹头发，等能坐下来吹头发时已经快十二点了。感觉很累。';
      map['author'] = 'BTPJ';
      map['comment'] = 10;
      map['portrait'] =
          'https://static.oschina.net/uploads/user/0/12_50.jpg?t=1421200584000';
      map['imgSmall'] =
          'https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg,https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg,https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg,https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg';
      normalTweetsList.add(map);
      hotTweetsList.add(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new TabBar(
              tabs: <Widget>[new Tab(text: "动弹列表"), new Tab(text: "热门动弹")]),
          body: new TabBarView(
              children: <Widget>[getNormalListView(), getHotListView()]),
        ));
  }

  /// 获取普通动弹列表
  Widget getNormalListView() {
    return new ListView.builder(
        itemCount: normalTweetsList.length * 2 - 1,
        itemBuilder: (context, index) => renderNormalRow(index));
  }

  /// 获取热门动弹列表
  getHotListView() {
    return new ListView.builder(
        itemCount: hotTweetsList.length * 2 - 1,
        itemBuilder: (context, index) => renderHotRow(index));
  }

  /// 渲染普通动弹列表Item
  renderNormalRow(int index) {
    if (index.isOdd) {
      return new Divider(
        height: 1.0,
      );
    } else {
      index = index ~/ 2;
      return getRowWidget(normalTweetsList[index]);
    }
  }

  /// 渲染热门动弹列表Item
  renderHotRow(int index) {
    if (index.isOdd) {
      return new Divider(
        height: 1.0,
      );
    } else {
      index = index ~/ 2;
      return getRowWidget(hotTweetsList[index]);
    }
  }

  /// 渲染Item
  Widget getRowWidget(Map<String, dynamic> listItem) {
    // 列表item的第一行，显示动弹作者头像、昵称、评论数
    var authorRow = new Row(
      children: <Widget>[
        // 用户头像
        new Container(
          width: 35.0,
          height: 35.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              image: new DecorationImage(
                  image: new NetworkImage(listItem['portrait']),
                  fit: BoxFit.cover),
              border: new Border.all(color: Colors.white, width: 2.0)),
        ),

        // 动弹作者的昵称
        new Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
          child: new Text(
            listItem['author'],
            style: new TextStyle(fontSize: 16.0),
          ),
        ),

        // 动弹评论数，显示在最右边
        new Expanded(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Text('${listItem['commentCount']}', style: subtitleStyle),
            new Image.asset(
              './images/ic_comment.png',
              width: 16.0,
              height: 16.0,
            )
          ],
        ))
      ],
    );

    // 动弹内容，纯文本展示
    var contentRow = new Row(
        children: <Widget>[new Expanded(child: new Text(listItem['body']))]);

    // 显示动弹发布时间
    var timeRow = new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Text(
          listItem['pubDate'],
          style: subtitleStyle,
        )
      ],
    );

    // 整个item的一个列布局
    var columns = <Widget>[
      new Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 2.0),
          child: authorRow),
      new Padding(
          padding: const EdgeInsets.fromLTRB(52.0, 0.0, 10.0, 0.0),
          child: contentRow)
    ];

    columns.add(new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 6.0),
      child: timeRow,
    ));

    // 动弹中的图片数据，字符串，多张图片以英文逗号分隔
    String imageSmall = listItem['imgSmall'];
    if (imageSmall != null && imageSmall.length > 0) {
      // 动弹中有图片
      List<String> list = imageSmall.split(",");
      List<String> imgUrlList = new List();
      for (String str in list) {
        if (str.startsWith("http")) {
          imgUrlList.add(str);
        } else {
          imgUrlList.add("https://static.oschina.net/uploads/space/$str");
        }
      }
      List<Widget> imgList = [];
      List<List<Widget>> rows = [];
      int len = imgUrlList.length;
      for (int row = 0; row < getRow(len); row++) {
        List<Widget> rowArr = [];
        for (var col = 0; col < 3; col++) {
          // col为列数，固定有3列
          int index = row * 3 + col;
          double cellWidth = (screenWidth - 100) / 3;
          if (index < len) {
            rowArr.add(new Padding(
              padding: const EdgeInsets.all(2.0),
              child: new Image.network(imgUrlList[index],
                  width: cellWidth, height: cellWidth),
            ));
          }
        }
        rows.add(rowArr);
      }
      for (var row in rows) {
        imgList.add(new Row(
          children: row,
        ));
      }
      columns.add(new Padding(
        padding: const EdgeInsets.fromLTRB(52.0, 5.0, 10.0, 0.0),
        child: new Column(
          children: imgList,
        ),
      ));
    }

    return new InkWell(
        child: new Column(children: columns),
        onTap: () {
          print("跳转到详情");
        });
  }

  /// 获取行数，n表示图片的张数;如果n取余不为0，则行数为n取整+1，否则n取整就是行数
  int getRow(int len) {
    int a = len % 3; // 取余
    int b = len ~/ 3; // 取整
    return a != 0 ? b + 1 : b;
  }
}
