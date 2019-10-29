
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
    // 加圆角
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }
  
  
  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if(gridNavModel == null) return items;
    if(gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if(gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if(gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first){
      List<Widget> items = [];
      items.add(_mainItem(context, gridNavItem.mainItem));
      items.add(_dobuleItem(context, gridNavItem.item1, gridNavItem.item2));
      items.add(_dobuleItem(context, gridNavItem.item3, gridNavItem.item4));
      List<Widget> andItems = [];
      items.forEach((item){
        andItems.add(Expanded(child: item, flex: 1,));
      });
      Color startColor = Color(int.parse("0xff" + gridNavItem.startColor));
      Color endColor = Color(int.parse("0xff" + gridNavItem.endColor));
      return Container(
        height: 88,
        margin: first?null:EdgeInsets.only(top: 3),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])
        ),
        child: Row(
          children: andItems,
        ),
      );
  }

  _mainItem(BuildContext context, CommonModel model){
    return _wrapGesture(context, Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Image.network(model.icon, fit: BoxFit.contain, height: 88, width: 121,
          alignment: AlignmentDirectional.bottomEnd,
        ),
        Container(
          margin: EdgeInsets.only(top: 11),
          child: Text(
            model.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        )
      ],
    ), model);
  }

  _dobuleItem(BuildContext context, CommonModel topModel, CommonModel bottomModel) {
      return Column(
        children: <Widget>[
          Expanded(
            child: _item(context, topModel, true),
          ),
          Expanded(
            child: _item(context, bottomModel, false),
          )
        ],
      );
  }

  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left:borderSide,
            bottom: first?borderSide:BorderSide.none,
          )
        ),
        child: _wrapGesture(context, Center(
          child: Text(item.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white),),
        ), item)
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model){
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> WebView(
                url: model.url,
                statusBarColor: model.statusBarColor,
                title: model.title,
                hideAppBar: model.hideAppbar,
              )
          ));
        },
      child: widget,
    );
  }
  
}

