import 'package:global_configs/global_configs.dart';

class Config {
  void loadFromMap(Map<String, dynamic> map) {
    GlobalConfigs().loadFromMap(map);
  }

  dynamic readValue<T>(String key) => GlobalConfigs().get(key);
}
