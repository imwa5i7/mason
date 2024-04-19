import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:{{project_name.snakeCase()}}/config/env-config.dart';
import 'package:{{project_name.snakeCase()}}/data/service/config.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Add cross-flavor configuration here
  EnvironmentConfig env = EnvironmentConfig();
  Config().loadFromMap(env.config);

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Palette.white,
      statusBarColor: Palette.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  runApp(await builder());
}
