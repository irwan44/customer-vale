import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/componen/color.dart';
import 'app/data/endpoint.dart';
import 'app/data/publik.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  startPollingNotifications();
  await GetStorage.init('token-mekanik');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await API();
  startPollingNotifications();

  runApp(const MyApp());
}
void startPollingNotifications() {
  const pollingInterval = Duration(minutes: 1);

  Timer.periodic(pollingInterval, (timer) async {
    await API.showBookingNotifications();
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "VALE Booking",
      initialRoute: Publics.controller.getToken.value.isEmpty
          ? AppPages.INITIAL
          : Routes.SPLASHSCREEN,
      getPages: AppPages.routes,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.contentColorWhite,
          foregroundColor: AppColors.contentColorBlack,
          iconTheme: IconThemeData(color: AppColors.contentColorBlack),
        ),
      ),
    );
  }
}
