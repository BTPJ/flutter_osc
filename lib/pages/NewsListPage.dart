import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osc/base/Constants.dart';
import 'package:flutter_osc/http/Api.dart';
import 'package:flutter_osc/http/NetUtil.dart';
import 'package:flutter_osc/widgets/CommonEndLine.dart';
import 'package:flutter_osc/widgets/SlideView.dart';

/// 资讯列表Tab界面
// ignore: must_be_immutable
class NewsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new NewsListPageState();
  }
}

class NewsListPageState extends State<NewsListPage> {
  /// 轮播图的数据
  var mSlideData;

  /// 列表的数据（轮播图数据和列表数据分开，但是实际上轮播图和列表中的item同属于ListView的item）
  var mListData;

  /// 监听listView的滚动事件
  ScrollController mController = new ScrollController();

  /// 当前页
  var mCurrentPage = 1;

  /// 列表数量
  var mListTotalSize = 0;

  /// 构造器
  NewsListPageState() {
    mController.addListener(() {
      // 表示列表的最大滚动距离
      var maxScroll = mController.position.maxScrollExtent;
      // 表示当前列表已向下滚动的距离
      var pixels = mController.position.pixels;
      // 如果两个值相等，表示滚动到底，并且如果列表没有加载完所有数据
      if (maxScroll == pixels && mListData.length < mListTotalSize) {
        mCurrentPage++; // 当前页索引加1
        getNewsList(true); // 获取下一页数据
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsList(false);
  }

  @override
  Widget build(BuildContext context) {
    // 无数据时显示Loading
    if (mListData == null) {
      return new Center(
        // CircularProgressIndicator是一个圆形的Loading进度条
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemBuilder: (context, index) => renderRow(index),
        itemCount: mListData.length * 2,
        controller: mController, // 监听列表滚动事件
      );
      return new RefreshIndicator(child: listView, onRefresh: pullToRefresh);
    }
  }

  Future<Null> pullToRefresh() async {
    //TODO 下拉刷新
    mCurrentPage = 1;
    getNewsList(false);
    return null;
  }

  /// 网络获取资讯列表
  void getNewsList(bool isLoadMore) {
    String url = Api.NEWS_LIST;
    // currentPage是定义在NewsListPageState中的成员变量，表示当前加载的页面索引
    url += "?pageIndex=$mCurrentPage&pageSize=10";
    NetUtil.get(url).then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型，需要导入包：import 'dart:convert';
        Map<String, dynamic> map = json.decode(data);
        if (map['code'] == 0) {
          // code=0表示请求成功
          var msg = map['msg'];
          // total表示资讯总条数
          mListTotalSize = msg['news']['total'];
          // data为数据内容，其中包含slide和news两部分，分别表示头部轮播图数据，和下面的列表数据
          var listData = msg['news']['data'];
          var slideData = msg['slide'];
          setState(() {
            if (!isLoadMore) {
              // 不是加载更多，则直接为变量赋值
              mListData = listData;
            } else {
              // 是加载更多，则需要将取到的news数据追加到原来的数据后面
              List list = new List();
              list.addAll(mListData);
              list.addAll(listData);
              // 判断是否获取了所有的数据，如果是，则需要显示底部的"我也是有底线的"布局
              if (list.length >= mListTotalSize) {
                list.add(Constants.END_LINE_TAG);
              }
              mListData = list;
            }
            mSlideData = slideData;
          });
        }
      }
    });
  }

  /// 渲染列表项
  renderRow(int index) {
    // 第一项为轮播图
    if (index == 0) {
      return new Container(
        height: 180.0,
        child: new SlideView(mSlideData),
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
    var itemData = mListData[index];
    if(itemData == Constants.END_LINE_TAG){
      return new CommonEndLine();
    }
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
              image: new ExactAssetImage('./images/ic_img_default.jpg'),
              fit: BoxFit.cover),
          border: new Border.all(color: const Color(0xFFECECEC), width: 2.0)),
    );
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {
      thumbImg = new Container(
          margin: const EdgeInsets.all(10.0),
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFECECEC),
            image: new DecorationImage(
                image: new NetworkImage(thumbImgUrl), fit: BoxFit.cover),
            border: new Border.all(
              color: const Color(0xFFECECEC),
              width: 2.0,
            ),
          ));
    }

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
