import 'package:final_weather_app/const/api_key.dart';
import 'package:final_weather_app/services/location.dart';
import 'package:final_weather_app/services/network.dart';
import 'package:final_weather_app/services/time.dart';

const String openWeatherApiURL =
    'https://api.openweathermap.org/data/2.5/weather';
// https://api.openweathermap.org/data/2.5/air_pollution?lat={lat}&lon={lon}&appid={API%20key}

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherApiURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    final Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherApiURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getAirQualityIndex(String cityName) async {
    TimeModule timeModule = TimeModule();
    await timeModule.getCityCoordinates(cityName);
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=${timeModule.cityLatitude}&lon=${timeModule.cityLongitude}&appid=$apiKey');

    var airQualityData = await networkHelper.getData();
    return airQualityData;
    //   var aqi = airQualityData['list'][0]['main']['aqi'];
  }

  Future<dynamic> getWeeklyWeather(String cityName) async {
    TimeModule timeModule = TimeModule();
    await timeModule.getCityCoordinates(cityName);
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.open-meteo.com/v1/dwd-icon?latitude=${timeModule.cityLatitude}&longitude=${timeModule.cityLongitude}&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset&timezone=auto');

    print('Weekly: Lat -> ${timeModule.cityLatitude}');
    print('Weekly: Lon -> ${timeModule.cityLongitude}');
    var weeklyWeatherData = await networkHelper.getData();
    return weeklyWeatherData;
  }

  String getAirQualityString(int aqi) {
    if (aqi == 1) {
      return 'Good';
    }
    if (aqi == 2) {
      return 'Fair';
    }
    if (aqi == 3) {
      return 'Moderate';
    }
    if (aqi == 4) {
      return 'Poor';
    }
    if (aqi == 5) {
      return 'very Poor';
    } else {
      return 'Not found';
    }
  }

  String getMonth(int month) {
    if (month == 1) {
      return 'January';
    }
    if (month == 2) {
      return 'February';
    }
    if (month == 3) {
      return 'March';
    }
    if (month == 4) {
      return 'April';
    }
    if (month == 5) {
      return 'May';
    }
    if (month == 6) {
      return 'June';
    }
    if (month == 7) {
      return 'July';
    }
    if (month == 8) {
      return 'August';
    }
    if (month == 9) {
      return 'September';
    }
    if (month == 10) {
      return 'October';
    }
    if (month == 11) {
      return 'November';
    }
    if (month == 12) {
      return 'December';
    } else {
      return '';
    }
  }

  List<String> getWeeklyWeatherImage(int weatherCode) {
    if (weatherCode == 0) {
      return ['01d.svg', 'clear sky'];
    } else if (weatherCode >= 1 && weatherCode <= 3) {
      if (weatherCode == 1) {
        return ['02d.svg', 'mainly clear'];
      } else if (weatherCode == 2) {
        return ['02d.svg', 'partly cloudy'];
      } else {
        return ['02d.svg', 'overcast'];
      }
    } else if (weatherCode == 45 || weatherCode == 48) {
      return ['50d.svg', 'fog'];
    } else if (weatherCode == 51 ||
        weatherCode == 53 ||
        weatherCode == 55 ||
        weatherCode == 66 ||
        weatherCode == 67) {
      if (weatherCode == 51) {
        return ['09d.svg', 'Drizzle light'];
      } else if (weatherCode == 53) {
        return ['09d.svg', 'Drizzle moderate'];
      } else if (weatherCode == 55) {
        return ['09d.svg', 'Drizzle heavy'];
      } else if (weatherCode == 66) {
        return ['09d.svg', 'Freezing light'];
      } else{
        return ['09d.svg', 'Freezing heavy'];
      }
    } else if (weatherCode == 56 ||
        weatherCode == 57 ||
        weatherCode == 71 ||
        weatherCode == 73 ||
        weatherCode == 75 ||
        weatherCode == 77 ||
        weatherCode == 85 ||
        weatherCode == 86) {
      return ['13d.svg', 'Freezing Drizzle'];
    } else if (weatherCode == 61 ||
        weatherCode == 63 ||
        weatherCode == 65 ||
        weatherCode == 80 ||
        weatherCode == 81 ||
        weatherCode == 82) {
      if (weatherCode == 61 || weatherCode == 80) {
        return ['10d.svg', 'Rain slight'];
      } else if (weatherCode == 63 || weatherCode == 81) {
        return ['10d.svg', 'Rain moderate'];
      } else {
        return ['10d.svg', 'Rain heavy'];
      }
    } else if (weatherCode == 95 || weatherCode == 96 || weatherCode == 99) {
      return ['11d.svg', 'Thunderstorm'];
    } else {
      return ['01d.png', 'Error'];
    }
  }
}
