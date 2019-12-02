abstract class TravelItemModel {
  int totalCount;
  List<TravelItem> resultList;



  TravelItemModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      resultList = new List<TravelItem>();
      json['resultList'].forEach((v) {
        resultList.add(new TravelItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.resultList != null) {
      data['resultList'] = this.resultList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




class TravelItem {
  String labelName;
  String groupChannelCode;

  TravelItem({this.labelName, this.groupChannelCode});

  TravelItem.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}

