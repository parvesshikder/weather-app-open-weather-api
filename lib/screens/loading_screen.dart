import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/weather.dart';

import '../services/networking.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  WeatherModel weatherModel = WeatherModel();

  Future<void> getLocation() async {
    var wdata = await weatherModel.getWeatherLocation();

  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LocationScreen(data: wdata),
    ));

    
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
