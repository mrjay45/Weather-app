import 'package:final_weather_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TemperatureImage extends StatelessWidget {
  final double containerHeight;
  final double imageHeight;
  final double fontSize;
  final String image;
  final String temperature;

  const TemperatureImage({
    super.key,
    this.containerHeight = 180,
    this.imageHeight = 160,
    this.fontSize = 150,
    required this.image,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight.h,
      child: Stack(
        children: [
          Text(
            '$temperature°',
            style: TextStyle(
              fontSize: fontSize,
              color: wordColor,
              fontWeight: FontWeight.bold,
              height: 1,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  offset: Offset(0, 0),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.9,
              child: SvgPicture.asset(
                image,
                height: imageHeight.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
