import 'package:final_weather_app/pages/loading_screen.dart';
import 'package:final_weather_app/services/internet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const HomePage());
  Get.put(InternetController(),permanent: true);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 802),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return const GetMaterialApp(
          home: LoadingScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
