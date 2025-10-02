import 'package:final_weather_app/Colors/colors.dart';
import 'package:final_weather_app/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Details extends StatelessWidget {
  final int humidity;
  final String aqi;
  final double containerHeight;
  final double containerWidth;
  final double containerRadius;
  final String visibility;
  const Details({
    super.key,
    this.containerHeight = 110,
    this.containerWidth = 350,
    this.containerRadius = 30,
    this.humidity = 20,
    this.aqi = 'Error',
    this.visibility = 'Error',
  });

  // Color getBackgroundColor(String aqi) {
  //   if (aqi == 'Good') {
  //     return Colors.green;
  //   }
  //   if (aqi == 'Fair') {
  //     return Colors.yellow;
  //   }
  //   if (aqi == 'Moderate') {
  //     return Colors.yellow.shade700;
  //   }
  //   if (aqi == 'Poor') {
  //     return Colors.red.shade500;
  //   }
  //   if (aqi == 'Very Poor') {
  //     return Colors.red.shade900;
  //   } else {
  //     return Colors.transparent;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight.h,
      width: containerWidth.w,
      decoration: BoxDecoration(
        color: secondaryColor,
        boxShadow: const [
          BoxShadow(
            color: Color(0xCF5F48AE),
            spreadRadius: 0,
            blurRadius: 15,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(containerRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          WeatherInformation(
            image: 'assets/visibility.png',
            information: visibility,
            name: 'Visibility',
          ),
          WeatherInformation(
            image: 'assets/humidity.png',
            information: '$humidity%',
            name: 'Humidity',
          ),
          WeatherInformation(
            image: 'assets/wind.png',
            information: aqi,
            name: 'Air Quality',
          ),
        ],
      ),
    );
  }
}
