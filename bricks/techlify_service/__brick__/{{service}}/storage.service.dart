import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:togo_mobile/config/console.dart';

import 'config.dart';

class StorageService {
  static Future<void> store(String key, dynamic value) async {
    try {
      const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

      const storage = FlutterSecureStorage();
      await storage.write(key: key, value: value.toString(), iOptions: options);
    } catch (e) {
      console(e);
    }
  }

  static Future<String?> read(String key) async {
    try {
      const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

      const storage = FlutterSecureStorage();
      return (await storage.read(key: key, iOptions: options));
    } catch (e) {
      console(e);
    }
    return null;
  }

  static Future<void> remove(String key) async {
    try {
      const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
      const storage = FlutterSecureStorage();

      await storage.delete(key: key, iOptions: options);
    } catch (e) {
      console(e.toString());
    }
  }

  static Future<void> clear() async {
    try {
      const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
      const storage = FlutterSecureStorage();
      await storage.delete(key: Config().readValue<String>('accessTokenKey'), iOptions: options);
      await storage.delete(key: Config().readValue<String>('expiryTsKey'), iOptions: options);
      await storage.delete(key: Config().readValue<String>('userStoreKey'), iOptions: options);
    } catch (e) {
      console(e.toString());
    }
  }
}
