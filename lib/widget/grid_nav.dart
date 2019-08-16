
import 'package:flutter/material.dart';
import 'package:my_app/Model/common_model.dart';
import 'package:my_app/Model/gridNav_model.dart';
import 'package:my_app/widget/webView.dart';

class GridNav extends StatelessWidget{
  final GridNavModel gridNavModel;

  const GridNav({Key key, @required this.gridNavModel}) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: _gridNavItem(context),
    );
  }
  
  
  _gridNavItem(BuildContext context){
    List<Widget> items = [];
    if(gridNavModel == null) return items;
    if(gridNavModel.hotel != null) {

    }
    if(gridNavModel.flight != null) {

    }
    if(gridNavModel.travel != null) {

    }
    return items;
  }
  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first){
      List<Widget> items = [];
      items.add(_mainItem(context, gridNavItem.mainItem));

  }

  _mainItem(BuildContext context, CommonModel model){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (content) =>
                WebView(url: model.url, statusBarColor: model.statusBarColor, title: model.title, hideAppBar: model.hideAppbar,)
            )
        );
      },
      child: Stack(
        children: <Widget>[
          Image.network(model.icon, fit: BoxFit.contain, height: 88, width: 121,
          alignment: AlignmentDirectional.bottomEnd,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      ),
    )
  }

  _dobuleItem(BuildContext context, CommonModel topModel, CommonModel bottomModel, bool isCenterItem) {
      return Column(
        children: <Widget>[
          Expanded(
            child: _item,
          )
        ],
      )
  }

  _item(BuildContext context, CommonModel item, bool first) {
    return FractionallySizedBox(

    )
  }
  
}

