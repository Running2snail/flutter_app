
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widget/webView.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();

}


class _MyPageState extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: WebView(
        url: 'https://m.ctrip.com/webapp/myctrip/',
        hideAppBar: true,
        backForbid: false,
        statusBarColor: '4c5bca',
      ),
    );
  }

}
