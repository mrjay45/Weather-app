import 'package:final_weather_app/Colors/colors.dart';
import 'package:final_weather_app/pages/loading_screen.dart';
import 'package:final_weather_app/services/hourly_weather.dart';
import 'package:final_weather_app/services/time.dart';
import 'package:final_weather_app/services/weather.dart';
import 'package:final_weather_app/widgets/details.dart';
import 'package:final_weather_app/widgets/hourly_weather.dart';
import 'package:final_weather_app/widgets/loading_widget.dart';
import 'package:final_weather_app/widgets/other_cities.dart';
import 'package:final_weather_app/widgets/temperature_image.dart';
import 'package:final_weather_app/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  final dynamic weatherData;
  final dynamic timeData;
  final dynamic airQualityData;
  final dynamic hourlyWeatherData;
  final dynamic weeklyWeatherData;

  const MainScreen({
    super.key,
    this.weatherData,
    this.timeData,
    this.airQualityData,
    this.hourlyWeatherData,
    this.weeklyWeatherData,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String temp = '00';
  String cityName = '';
  bool isClicked = false;
  int humidity = 20;
  String weatherId = '01d';
  String description = 'error';
  String dayOfWeek = 'none';
  int day = 00;
  String stringFormat = '';
  String month = '';
  String aqi = '';
  String visibility = '';
  // * Hourly weather data variables
  List<String> hTime = [];
  List<String> hWeatherId = [];
  List<String> hTemperature = [];
  // * weekly weather Data variables
  List<dynamic> wIconCode = [];
  List<String> wTempMax = [];
  List<String> wTempMin = [];
  List<String> wDate = [];
  late String searchCityName;
  final dateFormat = DateFormat('h:mm a');
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
    setTime(widget.timeData);
    setAirQuality(widget.airQualityData);
    setHourlyWeatherData(widget.hourlyWeatherData);
    setWeeklyWeatherData(widget.weeklyWeatherData);
  }

  void setWeeklyWeatherData(dynamic weeklyWeatherData) {
    for (int i = 0; i < 7; i++) {
      wTempMax
          .add(weeklyWeatherData['daily']['temperature_2m_max'][i].toString());
      wTempMin
          .add(weeklyWeatherData['daily']['temperature_2m_min'][i].toString());
      wIconCode.add(weeklyWeatherData['daily']['weather_code'][i]);
      wDate.add(weeklyWeatherData['daily']['time'][i].toString());
    }
  }

  void setHourlyWeatherData(dynamic hourlyWeatherData) {
    List list = hourlyWeatherData['list'];
    // String tempTime;
    int temp = 0;
    for (var data in list) {
      // tempTime = data['dt_txt'].split(' ')[1].split(':')[0];
      if (temp != 9) {
        hTime.add(DateFormat('hh:mm a').format(DateTime.parse(data['dt_txt'])));
        hWeatherId.add(data['weather'][0]['icon']);
        double temperature = data['main']['temp'].toDouble();
        hTemperature.add((temperature.toInt()).toString().padLeft(2, '0'));
        temp++;
      } else {
        break;
      }
    }
  }

  void setAirQuality(dynamic airQualityData) {
    setState(() {
      aqi = WeatherModel()
          .getAirQualityString(airQualityData['list'][0]['main']['aqi']);
    });
  }

  void setTime(dynamic timeData) {
    setState(() {
      dayOfWeek = timeData['dayOfWeek'];
      day = timeData['day'];
      stringFormat = dateFormat.format(DateTime.parse(timeData['dateTime']));
      month = WeatherModel().getMonth(timeData['month']);
    });
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      double temperature = weatherData['main']['temp'];
      temp = (temperature.toInt()).toString().padLeft(2, '0');
      cityName = weatherData['name'];
      humidity = weatherData['main']['humidity'];
      weatherId = weatherData['weather'][0]['icon'];
      description = weatherData['weather'][0]['description'];
      description = weatherData['weather'][0]['description'];
      visibilityConverter(weatherData['visibility']);
      print(temp);
      print(cityName);
    });
  }

  void visibilityConverter(int vis) {
    if (vis > 1000) {
      visibility = '${(vis / 1000)} Km';
    } else {
      visibility = '${vis}m';
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error 404'),
          content: SingleChildScrollView(
            child: Text('$searchCityName is not found'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    return LayoutBuilder(builder: (context, constrain) {
      if ((hTime.isEmpty)) {
        return const LoadingWidget();
      } else {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // first Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.grid_view_rounded,
                          color: wordColor,
                          size: 28,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isClicked = true;
                              });
                            },
                            child: (isClicked)
                                ? TextField(
                                    autofocus: true,
                                    focusNode: FocusNode(),
                                    onChanged: (value) {
                                      if (value == '') {
                                        searchCityName = cityName;
                                      } else {
                                        searchCityName = value;
                                      }
                                    },
                                    onSubmitted: (value) async {
                                      setState(() {
                                        isClicked = false;
                                        hTime = [];
                                        hWeatherId = [];
                                        hTemperature = [];
                                        wTempMax = [];
                                        wTempMin = [];
                                        wIconCode = [];
                                      });
                                      var weatherData = await WeatherModel()
                                          .getCityWeather(searchCityName);

                                      if (weatherData != null) {
                                        var airQualityData =
                                            await WeatherModel()
                                                .getAirQualityIndex(cityName);
                                        var timeData = await TimeModule()
                                            .getTimeData(searchCityName);
                                        var hourlyWeatherData =
                                            await HourlyWeatherData()
                                                .getHourlyWeatherData(
                                                    searchCityName);
                                        var weeklyWeatherData =
                                            await WeatherModel()
                                                .getWeeklyWeather(
                                                    searchCityName);
                                        setTime(timeData);
                                        updateUI(weatherData);
                                        setAirQuality(airQualityData);
                                        setHourlyWeatherData(hourlyWeatherData);
                                        setWeeklyWeatherData(weeklyWeatherData);
                                      } else {
                                        _showMyDialog();
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: wordColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: const InputDecoration(),
                                  )
                                : Text(
                                    cityName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: wordColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 45,
                        // margin: const EdgeInsets.only(right: 25.0),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoadingScreen();
                                },
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.refresh_rounded,
                            color: wordColor,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: wordColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                (constrain.maxHeight >= 750)
                    ? TemperatureImage(
                        image: 'assets/svgs/$weatherId.svg',
                        temperature: temp,
                      )
                    : TemperatureImage(
                        temperature: temp,
                        image: 'assets/svgs/$weatherId.svg',
                        containerHeight: 150.h,
                        imageHeight: 110.h,
                        fontSize: 120.sp,
                      ),
                Text(
                  '$dayOfWeek, $day $month | $stringFormat',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: wordColor,
                  ),
                ),
                SizedBox(height: 20.h),

                (constrain.maxHeight >= 750)
                    ? Details(
                        humidity: humidity,
                        aqi: aqi,
                        visibility: visibility,
                      )
                    : Details(
                        humidity: humidity,
                        aqi: aqi,
                        visibility: visibility,
                        containerHeight: 70.h,
                        containerWidth: 290.w,
                        containerRadius: 20,
                      ),
                SizedBox(height: 10.h),
                TextRow(
                  firstText: 'Today',
                  secondText: '7-Days Forecasts',
                  maxTemp: wTempMax,
                  minTemp: wTempMin,
                  weatherCode: wIconCode,
                  cityName: cityName,
                  dates: wDate,
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  height: 130.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: hTime.length,
                    itemBuilder: (context, index) {
                      return (index == 0)
                          ? Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: HourlyWeather(
                                hour: hTime[index],
                                weatherImage:
                                    'assets/svgs/${hWeatherId[index]}.svg',
                                temperature: '${hTemperature[index]}°',
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: HourlyWeather(
                                hour: hTime[index],
                                weatherImage:
                                    'assets/svgs/${hWeatherId[index]}.svg',
                                temperature: '${hTemperature[index]}°',
                              ),
                            );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                const TextRow(
                  firstText: 'Other Cities',
                  iconName: Icons.add,
                  weatherCode: [],
                ),
                SizedBox(height: 7.h),

                const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20),
                        OtherCites(
                          weatherImage: 'assets/sunny_2d.png',
                          cityName: 'New Zealand',
                        ),
                        SizedBox(width: 20),
                        OtherCites(
                            weatherImage: 'assets/rainy_2d.png',
                            cityName: 'Australia'),
                        SizedBox(width: 20),
                        OtherCites(
                          weatherImage: 'assets/snow_2d.png',
                          cityName: 'Portugal',
                        ),
                        SizedBox(width: 20),
                        OtherCites(
                          weatherImage: 'assets/thunder_2d.png',
                          cityName: 'Argentina',
                        ),
                        SizedBox(width: 20),
                      ],
                    )),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      }
    });
  }
}
// HourlyWeather(
//                         hour: '10 AM',
//                         weatherImage: 'assets/svgs/02d.svg',
//                         temperature: '23°',
//                       ),
//                     ),
//                     SizedBox(width: 15),
