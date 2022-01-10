import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/data/theme.dart';
import 'app/routes/app_pages.dart';

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.black, // navigation bar color
  //   // statusBarColor: Colors.pink, // status bar color
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      title: "Application",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
