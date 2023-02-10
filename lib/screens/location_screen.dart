import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';

import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final data;

  const LocationScreen({super.key, required this.data});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature ;
  late String cityName ;
  late String description ;
  late int condition ;
  late String weatherIcon ;
  late String message;
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    getDataUI(widget.data);
  }

  void getDataUI(dynamic data) {
    if(data == null){
      cityName = 'Unknown';
      temperature = 0;
      weatherIcon = 'Error';
      message = 'Unable to fetch data';
      return;
    }
    double temp = data['main']['temp'];
    cityName = data['name'];
    temperature = temp.toInt();
    description = data['weather'][0]['description'];
    condition = data['weather'][0]['id'];
    weatherIcon = weatherModel.getWeatherIcon(condition);
    message = weatherModel.getMessage(temperature);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getWeatherLocation();
                      setState(() {
                        getDataUI(weatherData);
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                     var cityName =  await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CityScreen(),));
                     if(cityName != null) {
                      var cityWeatherData = await weatherModel.getCityWeatherData(cityName);
                      setState(() {
                        getDataUI(cityWeatherData);
                      });
                     }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
