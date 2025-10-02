import 'package:final_weather_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherInformation extends StatelessWidget {
  final String image;
  final String information;
  final String name;
  final Color color;
  final Color textColor;

  const WeatherInformation({
    super.key,
    required this.image,
    required this.information,
    required this.name,
    this.color = Colors.transparent,
    this.textColor = wordColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: Image.asset(
            image,
            height: 30.0,
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color,
            ),
            child: Text(
              information,
              style: TextStyle(
                fontSize: 18.sp,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Flexible(
          child: Text(
            name,
            style: TextStyle(
              color: textColor,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
