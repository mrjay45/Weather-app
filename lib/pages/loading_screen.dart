import 'package:final_weather_app/pages/main_screen.dart';
import 'package:final_weather_app/services/hourly_weather.dart';
import 'package:final_weather_app/services/time.dart';
import 'package:final_weather_app/services/weather.dart';
import 'package:final_weather_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool activateConnection = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocationWeather();
  }

  void getCurrentLocationWeather() async {
    try{
      var weatherData = await WeatherModel().getLocationWeather();
    var timeData = await TimeModule().getTimeData(weatherData['name']);
    var airQualityData =
        await WeatherModel().getAirQualityIndex(weatherData['name']);
    var hourlyWeatherData = await HourlyWeatherData().getHourlyWeatherData(weatherData['name']);
    var weeklyWeatherData = await WeatherModel().getWeeklyWeather(weatherData['name']);
    mainScreen(weatherData, timeData, airQualityData,hourlyWeatherData,weeklyWeatherData);
    }
    catch (e){
      print('object');
    }
  }

  void mainScreen(data, timeData, airQualityData,hourlyWeatherData,weeklyWeatherData){
    Navigator.pushReplacement((context), MaterialPageRoute(
      builder: (context) {
        return MainScreen(
          weatherData: data,
          timeData: timeData,
          airQualityData: airQualityData,
          hourlyWeatherData: hourlyWeatherData,
          weeklyWeatherData: weeklyWeatherData,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingWidget();
  }
}
