import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

const apiKey = '6829ce2c78f02b4a092f61c55d7137bc';

class WeatherModel {
  Future getCityWeatherData(String cityName) async{
    String cityweatherurl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    NetworkingHelper networkingHelper = NetworkingHelper(url: cityweatherurl);

    var weatherdata = await networkingHelper.getData();
    return weatherdata;
  }

  Future getWeatherLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkingHelper networkingHelper = NetworkingHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherdata = await networkingHelper.getData();

    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
