import 'package:{{project_name.snakeCase()}}/config/app.config.local.dart';
import 'package:{{project_name.snakeCase()}}/config/app.config.prod.dart';
import 'package:{{project_name.snakeCase()}}/config/app.config.staging.dart';

class EnvironmentConfig {
  final String command = const String.fromEnvironment('env');
  late Map<String, dynamic> config;
  EnvironmentConfig() {
    config = command == 'local'
        ? localAppConfig
        : command == 'staging'
            ? stagingAppConfig
            : prodAppConfig;
  }
}
