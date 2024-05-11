import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@Singleton(order: -1)
class LocalStorage {
  const LocalStorage._();

  @factoryMethod
  static Future<LocalStorage> create() async {
    // Hive initialize
    _hiveStorage ??= await Hive.openBox('LocalStorage');

    // FlutterSecureStorage initialize
    _secureStorage ??= const FlutterSecureStorage();

    return const LocalStorage._();
  }

  /* ------------------ SECURE STORAGE ----------------------- */

  static FlutterSecureStorage? _secureStorage;

  /// Reads the decrypted value for the key from secure storage
  Future<String?> getEncrypted(String key) {
    try {
      return _secureStorage!.read(key: key);
    } on PlatformException {
      return Future<String?>.value();
    }
  }

  /// Sets the encrypted value for the key to secure storage
  Future<bool> saveEncrypted(String key, String value) async {
    try {
      await _secureStorage!.write(key: key, value: value);
      return Future<bool>.value(true);
    } on PlatformException catch (_) {
      return Future<bool>.value(false);
    }
  }

  /// Erases encrypted keys
  Future<void> clearEncrypted() => _secureStorage!.deleteAll();

  /* ------------------ HIVE STORAGE ----------------------- */

  static Box? _hiveStorage;

  /// Generates a secure encryption key using the fortuna random algorithm.
  String generateSecureKey() => base64UrlEncode(Hive.generateSecureKey());

  /// Returns a [ValueListenable] which notifies its listeners when an entry in the box changes.
  ValueListenable<Box<dynamic>> listenable({List<dynamic>? keys}) => _hiveStorage!.listenable(keys: keys);

  /// Return the value associated with the given [key]. If the key does not exist, `null` is returned.
  T? getItem<T>(Object key, {T? defaultValue}) {
    try {
      return _hiveStorage!.get(key, defaultValue: defaultValue);
    } catch (_) {
      _hiveStorage?.delete(key);

      return null;
    }
  }

  /// Set the value for the key to common get storage
  /// Can save String, int, double, Map
  Future<void> saveItem<T>(Object key, T? value) {
    if (value != null) {
      return _hiveStorage!.put(key, value);
    } else {
      return _hiveStorage!.delete(key);
    }
  }

  /// Erases get storage keys
  Future<void> clear() => _hiveStorage!.clear();
}
