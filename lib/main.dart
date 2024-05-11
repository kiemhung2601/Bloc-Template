import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'module/app/app.dart';

void main() async {
  runZonedGuarded(() async {
    /// Show splash screen
    MyApp.preserveSplash(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

    /// Set portrait orientations the application
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Hive
    await Hive.initFlutter();

    /// Inital App
    await MyApp.resolveDependencies();

    runApp(const MyApp());
  }, (error, stack) {});
}
