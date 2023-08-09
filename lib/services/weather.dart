import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';

const apiKey = '687a93dfd6b0fd21d997f87c0760bfdf';
const urlMain = 'api.openweathermap.org';

class WeatherModel {
  Future<dynamic> getCityWeather(String city) async {
    Uri url = Uri.https(urlMain, 'data/2.5/weather', {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
    });
    NetworkHelper networkHelper = NetworkHelper(url.toString());

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Uri url = Uri.https(urlMain, 'data/2.5/weather', {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'appid': apiKey,
      'units': 'metric'
    });
    NetworkHelper networkHelper = NetworkHelper(url.toString());

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
