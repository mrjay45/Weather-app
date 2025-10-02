import 'package:final_weather_app/Colors/colors.dart';
import 'package:final_weather_app/widgets/weekly_weather.dart';
import 'package:flutter/material.dart';

class WeekForecast extends StatefulWidget {
  final List<String>? maxTemp;
  final List<String>? minTemp;
  final List<dynamic> weatherCode;
  final String cityName;
  final List<String>? dates;
  const WeekForecast(
      {super.key,
      this.maxTemp,
      this.minTemp,
      required this.cityName,
      required this.weatherCode,
      this.dates});

  @override
  State<WeekForecast> createState() => _WeekForecastState();
}

class _WeekForecastState extends State<WeekForecast> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        backgroundColor: backgroundColor.withOpacity(0.3),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: secondaryColorP2,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios_new),
                            color: wordColor,
                          ),
                        ),
                      ),
                      Text(
                        widget.cityName,
                        style: const TextStyle(
                          fontSize: 21,
                          color: wordColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 45,
                        // margin: const EdgeInsets.only(right: 25.0),
                        decoration: BoxDecoration(
                          color: secondaryColorP2,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.refresh_rounded,
                          color: wordColor,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: constrains.maxHeight / 2.5,
                  width: constrains.maxWidth / 1.2,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: secondaryColorP2,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 190,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/sunny_2d.png',
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                                const Positioned(
                                  bottom: 5,
                                  right: 40,
                                  child: Text(
                                    '19°',
                                    style: TextStyle(
                                      fontSize: 70,
                                      color: wordColor,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0, 0),
                                          blurRadius: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  bottom: 0,
                                  right: 10,
                                  child: Text(
                                    '/15°',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: wordColor,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0, 0),
                                          blurRadius: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Column(
                            children: <Widget>[
                              Text(
                                'Tomorrow',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: wordColor,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Mostly Sunny',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: wordColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/precipitation.png',
                                height: 30.0,
                              ),
                              const Text(
                                '22%',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: wordColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'precipitation',
                                style: TextStyle(
                                  color: wordColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/humidity.png',
                                height: 30.0,
                              ),
                              const Text(
                                '20%',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: wordColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Humidity',
                                style: TextStyle(
                                  color: wordColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/wind.png',
                                height: 30.0,
                              ),
                              const Text(
                                '9km/h',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: wordColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Wind Speed',
                                style: TextStyle(
                                  color: wordColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                WeeklyWeather(
                  maxTemp: widget.maxTemp![0].toString().split('.')[0],
                  minTemp: widget.minTemp![0].toString().split('.')[0],
                  dayOfWeek: widget.dates![0],
                  weatherCode: widget.weatherCode[0],
                ),
                const SizedBox(height: 20),
                WeeklyWeather(
                  maxTemp: widget.maxTemp![1].toString().split('.')[0],
                  minTemp: widget.minTemp![1].toString().split('.')[0],
                  dayOfWeek: widget.dates![1],
                  weatherCode: widget.weatherCode[1],
                ),
                const SizedBox(height: 20),
                WeeklyWeather(
                  maxTemp: widget.maxTemp![2].toString().split('.')[0],
                  minTemp: widget.minTemp![2].toString().split('.')[0],
                  dayOfWeek: widget.dates![2],
                  weatherCode: widget.weatherCode[2],
                ),
                const SizedBox(height: 20),
                WeeklyWeather(
                  minTemp: widget.minTemp![3].toString().split('.')[0],
                  maxTemp: widget.maxTemp![3].toString().split('.')[0],
                  dayOfWeek: widget.dates![3],
                  weatherCode: widget.weatherCode[3],
                ),
                const SizedBox(height: 20),
                WeeklyWeather(
                  maxTemp: widget.maxTemp![4].toString().split('.')[0],
                  minTemp: widget.minTemp![4].toString().split('.')[0],
                  dayOfWeek: widget.dates![4],
                  weatherCode: widget.weatherCode[4],
                ),
                const SizedBox(height: 20),
                WeeklyWeather(
                  maxTemp: widget.maxTemp![5].toString().split('.')[0],
                  minTemp: widget.minTemp![5].toString().split('.')[0],
                  dayOfWeek: widget.dates![5],
                  weatherCode: widget.weatherCode[5],
                ),
                const SizedBox(height: 20),
                WeeklyWeather(
                  maxTemp: widget.maxTemp![6].toString().split('.')[0],
                  minTemp: widget.minTemp![6].toString().split('.')[0],
                  dayOfWeek: widget.dates![6],
                  weatherCode: widget.weatherCode[6],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    });
  }
}
