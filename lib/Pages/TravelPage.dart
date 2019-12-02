
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Model/travel_tab_model.dart';
import 'package:my_app/Pages/TravelTabPage.dart';
import 'package:my_app/dao/travel_tab_dao.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();

}


class _TravelPageState extends State<TravelPage> with SingleTickerProviderStateMixin{

  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;


  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e){
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Color(0xff2fcfbb),
                    width: 3,
                  ),
                  insets: EdgeInsets.only(bottom: 10)
                ),
                tabs: tabs.map<Tab>((TravelTab tab){
                  return Tab(
                    text: tab.labelName,
                  );
                }).toList()),
          ),
          Flexible(
              child: TabBarView(
              controller: _controller,
              children:tabs.map((TravelTab tab) {
                return TravelTabPage(
                  travelUrl: travelTabModel.url,
                  params: travelTabModel.params,
                  groupChannelCode: tab.groupChannelCode,
                );
              }).toList()
          ))
        ],
      ),
    );
  }

}
