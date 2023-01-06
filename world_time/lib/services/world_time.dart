import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //location name for the UI
  String flag; //url to an asset flag icon
  String url; //location url for api endpoints
  String time = ""; //the time in that location
  late bool isDayTime; //true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url });

  Future<void> getTime() async{

    try{
      //make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDayTime = now.hour > 5 && now.hour < 20 ? true:false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error: $e');
      time = 'could not get time data';
    }

  }

}