import 'package:final_weather_app/Colors/colors.dart';
import 'package:final_weather_app/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class WeeklyWeather extends StatefulWidget {
  final String maxTemp;
  final String minTemp;
  final String dayOfWeek;
  final int weatherCode;
  const WeeklyWeather(
      {super.key,
      required this.maxTemp,
      required this.minTemp,
      required this.dayOfWeek,
      required this.weatherCode});
  @override
  State<WeeklyWeather> createState() => _WeeklyWeatherState();
}

class _WeeklyWeatherState extends State<WeeklyWeather> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 90.w,
          child: Text(
            DateFormat('EEEE').format(DateTime.parse(widget.dayOfWeek)),
            style: TextStyle(
              color: wordColor,
              fontSize: 18.sp,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SvgPicture.asset(
              'assets/svgs/${WeatherModel().getWeeklyWeatherImage(widget.weatherCode)[0]}',
              height: 45.h,
            ),
            SizedBox(width: 10.w),
            SizedBox(
              width: 100.w,
              child: Text(
                WeatherModel().getWeeklyWeatherImage(widget.weatherCode)[1],
                style:  TextStyle(
                  color: wordColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
        Text(
          '+${widget.maxTemp}°',
          style: TextStyle(
            color: wordColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '+${widget.minTemp}°',
          style: TextStyle(
            color: wordColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
