
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage({Key key, this.hideLeft, this.searchUrl, this.keyword, this.hint}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();

}


class _SearchPageState extends State<SearchPage>{

  String keyword;

  @override
  void initState() {
    if(widget.keyword != null) {
      
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("搜索"),
      ),
      body: Center(
        child: Text("搜索"),
      ),
    );
  }

}
