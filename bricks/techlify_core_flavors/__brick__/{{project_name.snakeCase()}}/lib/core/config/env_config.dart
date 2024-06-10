import 'app.config.local.dart';
import 'app.config.prod.dart';
import 'app.config.staging.dart';

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
