import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location ; //location name for Ui
  String time ; //the time in that location
  String flag ; //url to asset flag icon
  String url ; //location url for apu endpoint
  bool isDaytime;

  WorldTime({this.location,this.url,this.flag});

   Future <void> getTime() async {
  
     try {

         //make the request
    Response response = await get('https://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);
    //print(data);

    //get properties from data
    String datetime = data['utc_datetime'];
    String offset = data['utc_offset'].substring(1,3);
    //print(datetime + offset);

    //create datetime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    //time property
    isDaytime = now.hour > 6 && now.hour < 15 ? true : false;
    time = DateFormat.jm().format(now);

       
     } catch (e) {

         print('Caught error : $e');
         time = 'Could not get the data';
     }

  }
}

