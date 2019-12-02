
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/HomePage.dart';
import 'package:my_app/Pages/MyPage.dart';
import 'package:my_app/Pages/SearchPage.dart';
import 'package:my_app/Pages/TravelPage.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();

}


class _TabNavigatorState extends State<TabNavigator>{
  final PageController _controller = PageController(
    initialPage: 0,

  );

  final _defaultColor = Colors.grey;
  final _activityColor = Colors.blue;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true,),
          TravelPage(),
          MyPage(),

        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: (index){
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.home, color: _defaultColor, ),
          activeIcon: Icon( Icons.home, color: _activityColor, ),
          title: Text(
            "首页",
            style: TextStyle(color: _currentIndex == 0 ? _activityColor : _defaultColor),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.search, color: _defaultColor, ),
          activeIcon: Icon( Icons.search, color: _activityColor, ),
          title: Text(
            "搜索",
            style: TextStyle(color: _currentIndex == 1 ? _activityColor : _defaultColor),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.camera_alt, color: _defaultColor, ),
          activeIcon: Icon( Icons.camera_alt, color: _activityColor, ),
          title: Text(
            "旅拍",
            style: TextStyle(color: _currentIndex == 2 ? _activityColor : _defaultColor),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.account_circle, color: _defaultColor, ),
          activeIcon: Icon( Icons.account_circle, color: _activityColor, ),
          title: Text(
            "我的",
            style: TextStyle(color: _currentIndex == 3 ? _activityColor : _defaultColor),
          ),
        ),
      ]),
    );
  }

}
