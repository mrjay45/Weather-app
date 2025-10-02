import 'package:final_weather_app/Colors/colors.dart';
import 'package:final_weather_app/pages/week_forecast.dart';
import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  final String firstText;
  final String? secondText;
  final IconData? iconName;
  final List<String>? maxTemp;
  final List<String>? minTemp;
  final List<dynamic> weatherCode;
  final List<String>? dates;
  final String cityName;

  const TextRow({
    super.key,
    required this.firstText,
    this.secondText,
    this.iconName,
    this.maxTemp,
    this.minTemp,
    this.cityName = 'Error',
    required this.weatherCode,
    this.dates,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            firstText,
            style: const TextStyle(
              fontSize: 16,
              color: wordColor,
            ),
          ),
          Container(
            child: secondText == null
                ? Icon(
                    iconName,
                    size: 24,
                    color: wordColor,
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return WeekForecast(
                            maxTemp: maxTemp,
                            minTemp: minTemp,
                            weatherCode: weatherCode,
                            cityName: cityName,
                            dates: dates,
                          );
                        },
                      ));
                    },
                    child: Text(
                      secondText!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: wordColor,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
