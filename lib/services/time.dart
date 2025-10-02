// import 'package:final_weather_app/services/location.dart';
import 'package:final_weather_app/const/api_key.dart';
import 'package:final_weather_app/services/network.dart';

class TimeModule {
  double cityLatitude = 00;
  double cityLongitude = 00;
  Future<dynamic> getCityCoordinates(String cityName) async {
    const String openWeatherApiURL =
        'https://api.openweathermap.org/geo/1.0/direct';

    NetworkHelper networkHelper =
        NetworkHelper('$openWeatherApiURL?q=$cityName&limit=1&appid=$apiKey');
    var cityCoordinateData = await networkHelper.getData();
    cityLatitude = cityCoordinateData[0]['lat'];
    cityLongitude = cityCoordinateData[0]['lon'];
  }

  Future<dynamic> getTimeData(String cityName) async {
    await getCityCoordinates(cityName);
    NetworkHelper networkHelper = NetworkHelper(
        'https://www.timeapi.io/api/Time/current/coordinate?latitude=$cityLatitude&longitude=$cityLongitude');

    var timeZoneData = await networkHelper.getData();
    return timeZoneData;
  }
}
