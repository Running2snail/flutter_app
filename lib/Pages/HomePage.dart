
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/Model/common_model.dart';
import 'package:my_app/Model/gridNav_model.dart';
import 'package:my_app/Model/home_model.dart';
import 'package:my_app/Model/sales_box_model.dart';
import 'package:my_app/dao/home_dao.dart';
import 'package:my_app/util/navigator_util.dart';
import 'dart:convert';
import 'package:my_app/widget/grid_nav.dart';
import 'package:my_app/widget/loading_container.dart';
import 'package:my_app/widget/local_nav.dart';
import 'package:my_app/widget/sales_box.dart';
import 'package:my_app/widget/sub_nav.dart';
import 'package:my_app/widget/webView.dart';

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
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

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
    _handleRefresh();
    Future.delayed(Duration(milliseconds: 600), () {
      FlutterSplashScreen.hide();
    });
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        bannerList = model.bannerList;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
        _loading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                  child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: _listView,
              ),
                  onRefresh: _handleRefresh),
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
        ),
      )
    );
  }


  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: GridNav(gridNavModel: gridNavModel)),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SubNav(subNavList: subNavList)),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SalesBox(salesBox: salesBoxModel)),
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList[index];
              NavigatorUtil.push(
                  context,
                  WebView(
                      url: model.url,
                      title: model.title,
                      hideAppBar: model.hideAppbar));
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

}
