import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          surfaceTintColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
    ),
  );

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    doWhenWindowReady(() {
      const initialSize = Size(1440, 824);
      appWindow.maxSize = initialSize;
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.show();
    });
  }
}
