import 'package:{{project_name.snakeCase()}}/presentation/splash/splash_screen.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
          double.parse("{{screen_width}}"), double.parse("{{screen_height}}")),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: '{{project_name.titleCase()}}',
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(),
          onGenerateRoute: RouteGenerator.getRoute,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
