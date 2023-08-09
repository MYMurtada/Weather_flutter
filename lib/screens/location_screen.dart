import 'package:flutter/material.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:clima_flutter/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  //double temperature; =
  late int temperature;

  //int condition; =
  late String weatherIcon;
  late String weatherMessage;
  late String cityName;
  String massage = 'unable to get the weather data!';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        cityName = '';
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherIcon = "";
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
      massage = "$weatherMessage";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: Colors.green[500],
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        cityName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: Checkbox.width * 2,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        String cityCalled = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityScreen()));
                        updateUI(await weather.getCityWeather(cityCalled));
                      },
                      child: Icon(
                        Icons.location_city_outlined,
                        size: 50.0,
                        color: Colors.green[500],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '$temperature°',
                              style: kTempTextStyle,
                            ),
                            Text(
                              weatherIcon.toString(),
                              style: kConditionTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 40.0, right: 40.0, bottom: 100.0),
                          child: Text(
                            massage,
                            textAlign: TextAlign.center,
                            style: kMessageTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
