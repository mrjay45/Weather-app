import 'package:final_weather_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HourlyWeather extends StatelessWidget {
  final String hour;
  final String weatherImage;
  final String temperature;
  final Color backgroundColor;
  const HourlyWeather({
    super.key,
    required this.hour,
    required this.weatherImage,
    required this.temperature,
    this.backgroundColor = secondaryColor,
  });
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      height: (deviceHeight >= 750) ? 120 : 90,
      width: (deviceHeight >= 750) ? 70 : 50,
      // height: 90,
      // width: 30,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: (deviceHeight >= 750)
            ? BorderRadius.circular(25.0)
            : BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: Text(
              hour,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: (deviceHeight >= 750) ? 14 : 10,
                color: wordColor,
              ),
            ),
          ),
          Flexible(
              child: SvgPicture.asset(
            weatherImage,
            height: (deviceHeight >= 750) ? 40.0 : 20.0,
          )),
          Flexible(
            child: Text(
              temperature,
              style: TextStyle(
                fontSize: (deviceHeight >= 750) ? 14 : 10,
                color: wordColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
