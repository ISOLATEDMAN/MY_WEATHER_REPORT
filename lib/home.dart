import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:real_wether/const.dart';
import 'package:weather/weather.dart';
import 'package:lottie/lottie.dart';

class Weat extends StatefulWidget {
  const Weat({super.key});

  @override
  State<Weat> createState() => _WeatState();
}

class _WeatState extends State<Weat> {
 
 final WeatherFactory wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    wf.currentWeatherByCityName('Hyderabad').then((w) => {
      setState(() {
        _weather = w;
      })
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: _build(),
    );
  }

  Widget _build(){
    if(_weather==null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(), 
          SizedBox(height: 5,),  
          _datetimeinfo(),
          SizedBox(height: 30,),
          _weathers(),
          SizedBox(height: 20,),
          Container(
            child: _state(),
          ),
          

        ],
      ),
    );
  }
  Widget _locationHeader(){
    return Text(_weather?.areaName ?? "",style: TextStyle(fontSize: 30),);
  }
  Widget _datetimeinfo(){
    DateTime now = _weather!.date!;
    return Column(
      children:[
        Text(DateFormat("h:mm:a").format(now),style: TextStyle(fontSize: 35),),
        SizedBox(height: 3,),

        Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat("EEEE").format(now),
            style: TextStyle(fontSize: 15 ),
            ),
            Text(" ${DateFormat("d.m.y").format(now)}",style: TextStyle(fontSize: 10),),
            ]
            ),

        ]);
  }
  Widget _weathers(){

    return Container(
      color: Colors.amber,
      padding: EdgeInsets.all(30),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Text("Temperature: ${_weather?.temperature?.celsius?.toStringAsFixed(0) ?? 'N/A'} C"),
        Text("Max Temperature: ${_weather?.tempMax ?? 'N/A'} C"),
        Text("Min Temperature: ${_weather?.tempMin ?? 'N/A'} C"),
        Text("Country: ${_weather?.country ?? 'N/A'}"),
          ],
      ),
    );

  }

Widget _state() {
  Temperature? t = _weather?.temperature;

  int? t1 = parseIntFromTemperature(t);

  if (t1 != null && t1 > 30) {
    print(t1);
    return Container(
      child: Lottie.asset("assets/sunny.json", height: 350, width: 400),
    );
  } else {
    print(t1);
    return Container(
      child: Lottie.asset("assets/chill.json", height: 350, width: 400),
    );
  }
}

int? parseIntFromTemperature(Temperature? temperature) {
  try {
    // Assuming toString provides a string representation of the temperature value
    String stringValue = temperature?.toString() ?? '';
    return int.parse(stringValue);
  } catch (e) {
    return null; // Parsing failed
  }
}




  }
  
  
  