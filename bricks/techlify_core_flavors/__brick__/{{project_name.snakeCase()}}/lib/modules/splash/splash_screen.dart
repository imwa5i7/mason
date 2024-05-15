import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      //TODO:Navigate to a route.
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: Center(
        child: Image.asset(
          ImageAssets.logo,
          height: Sizes.s140.h,
        ),
      ),
    );
  }
}
