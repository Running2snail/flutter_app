
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/Model/common_model.dart';
import 'package:my_app/Model/home_model.dart';
import 'package:my_app/dao/home_dao.dart';
import 'dart:convert';
import 'package:my_app/widget/grid_nav.dart';
import 'package:my_app/widget/local_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage>{
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];
  double appBarAlpha = 0;

  String resultString = "";

  List<CommonModel> localNavList = [];

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
//    HomeDao.fetch().then((result){
//      setState(() {
//        resultString = js
//      });
//    });
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
//        resultString = json.encode(model.config);
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff2f2),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child:NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                        _onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child:new ListView(
                    children: <Widget>[
                      Container(
                        height: 240,
                        child: Swiper(
                          itemCount: _imageUrls.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index){
                            return Image.network(
                              _imageUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
//                          viewportFraction: 0.8,
//                          scale: 0.9,
                        ),
                      ),
//                      ListTile(
//                        title: new Text('SwiperController', style: TextStyle(fontWeight: FontWeight.w500),),
//                        subtitle: new Text('iconPrevious'),
//                        leading: new Icon(Icons.account_box, color: Colors.lightBlue),
//                      ),
//                      new Divider(),
//                      ListTile(
//                        title: new Text('SwiperController', style: TextStyle(fontWeight: FontWeight.w500),),
//                        subtitle: new Text('scrollDirection'),
//                        leading: new Icon(Icons.account_box, color: Colors.lightBlue),
//                      ),
//                      new Divider(),
//                      ListTile(
//                        title: new Text('SwiperController', style: TextStyle(fontWeight: FontWeight.w500),),
//                        subtitle: new Text('onIndexChanged'),
//                        leading: new Icon(Icons.account_box, color: Colors.lightBlue),
//                      ),
//                      new Divider(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: LocalNav(localNavList: localNavList),
                      ),
                      Container(
                        height: 400,
                        child: ListTile(
                          title: Text(resultString),
                        ),
                      ),
                    ],
                  ),
              ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                      "首页",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }

}
