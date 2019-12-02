import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/Model/home_model.dart';
import 'package:my_app/Model/travel_tab_model.dart';


class TravelTabDao{
  static Future<TravelTabModel> fetch() async {
    final response = await http.
    get('http://www.devio.org/io/flutter_app/json/travel_page.json');
    if(response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception("Failed to load travel_page.json");
    }
  }
}