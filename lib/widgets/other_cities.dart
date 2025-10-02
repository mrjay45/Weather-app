import 'package:final_weather_app/Colors/colors.dart';
import 'package:flutter/material.dart';

class OtherCites extends StatelessWidget {
  final String weatherImage;
  final String cityName;
  const OtherCites({
    super.key,
    required this.weatherImage,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: (deviceHeight >= 750) ? 80 : 50,
      width: (deviceHeight >= 750) ? 300 : 250,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset(
              weatherImage,
              height: 50,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  cityName,
                  style: TextStyle(
                    fontSize: (deviceHeight >= 750) ? 16 : 12,
                    fontWeight: FontWeight.bold,
                    color: wordColor,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  'sunny',
                  style: TextStyle(
                    fontSize: (deviceHeight >= 750) ? 12 : 10,
                    color: wordColor,
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: Text(
              '9°',
              style: TextStyle(
                fontSize: (deviceHeight >= 750) ? 28 : 20,
                fontWeight: FontWeight.bold,
                color: wordColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
