import 'package:final_weather_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
const LoadingWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      color: backgroundColor,
      child: const Center(
        child: SpinKitPouringHourGlass(
          size: 100.0,
          color: secondaryColor,
        ),
      ),
    );
  }
}