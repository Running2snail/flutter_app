
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Model/travel_model.dart';
import 'package:my_app/dao/travel_dao.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_app/util/navigator_util.dart';
import 'package:my_app/widget/webView.dart';

const _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  @override
  final String travelUrl;
  final Map params;
  final String groupChannelCode;

  const TravelTabPage({Key key, this.travelUrl, this.params, this.groupChannelCode}) : super(key: key);


  _TravelTabPageState createState() => _TravelTabPageState();

}


class _TravelTabPageState extends State<TravelTabPage> with SingleTickerProviderStateMixin{

  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool _loading = true;



  @override
  void initState() {

    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: travelItems?.length ?? 0,
        itemBuilder: (BuildContext context, int index) => _TravelItem(index: index, item: travelItems[index]),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      )
    );
  }

  void _loadData(){

    TravelDao.fetch(widget.travelUrl ?? _TRAVEL_URL, widget.params, widget.groupChannelCode, pageIndex, PAGE_SIZE).then((TravelItemModel model) {

      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });

    }).catchError((e) {
      print(e);
    });
  }

  List<TravelItem> _filterItems([List<TravelItem> resultList]){

    if (resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    resultList.forEach((item){
      if (item.article != null) {
        filterItems.add(item);
      }
    });
    return filterItems;
  }


}


class _TravelItem extends StatelessWidget {
  final int index;
  final TravelItem item;

  const _TravelItem({Key key, this.index, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.article.urls != null && item.article.urls.length > 0) {

          NavigatorUtil.push(
              context,WebView(
            url: item.article.urls[0].h5Url,
            title: '详情',
          ));
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemImage(),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article.articleTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText()
            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Image.network(item.article.images[0]?.dynamicUrl),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 12,
                      )),
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _poiName(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  String _poiName() {
    return item.article.pois == null || item.article.pois.length == 0
        ? '未知'
        : item.article.pois[0]?.poiName ?? '未知';
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article.author?.coverImage?.dynamicUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item.article.author?.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
