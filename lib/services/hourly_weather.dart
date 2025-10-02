import 'package:final_weather_app/const/api_key.dart';
import 'package:final_weather_app/services/network.dart';
import 'package:final_weather_app/services/time.dart';

const String openWeatherApiURL = 'https://api.openweathermap.org/data/2.5/forecast';
class HourlyWeatherData{
  
  Future<dynamic> getHourlyWeatherData(String cityName) async{
    TimeModule timeModule = TimeModule();
    await timeModule.getCityCoordinates(cityName);
    NetworkHelper networkHelper = NetworkHelper('$openWeatherApiURL?lat=${timeModule.cityLatitude}&lon=${timeModule.cityLongitude}&appid=$apiKey&units=metric');

    var hourlyWeatherData = await networkHelper.getData(); 

    return hourlyWeatherData;
  }
}