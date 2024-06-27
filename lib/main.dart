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
  await API.showBookingNotificationsApprove();
  await API.showBookingNotificationsBooking();
  await API.showBookingNotificationsDiproses();
  await API.showBookingNotificationsEstimasi();
  await API.showBookingNotificationsPKB();
  await API.showBookingNotificationsPKBTUTUP();
  await API.showBookingNotificationsSelesaiDikerjakan();
  await API.showBookingNotificationsInvoice();
  await API.showBookingNotificationsLunas();
  await API.showBookingNotificationsDitolak();
  await startPollingNotificationsApprove();
  await startPollingNotificationsBooking();
  await startPollingNotificationsDiproses();
  await startPollingNotificationsEstimasi();
  await startPollingNotificationsPKB();
  await startPollingNotificationsPKBTUTUP();
  await startPollingNotificationsDikerjakan();
  await startPollingNotificationsDikerjakan();
  await startPollingNotificationsInvoice();
  await startPollingNotificationsLunas();
  await startPollingNotificationsDitolak();

  runApp(const MyApp());
}

Future<void> startPollingNotificationsApprove() async {
  await API.showBookingNotificationsApprove();
}Future<void> startPollingNotificationsBooking() async {
  await API.showBookingNotificationsBooking();
}Future<void> startPollingNotificationsDiproses() async {
  await API.showBookingNotificationsDiproses();
}Future<void> startPollingNotificationsEstimasi() async {
  await API.showBookingNotificationsEstimasi();
}Future<void> startPollingNotificationsPKB() async {
  await API.showBookingNotificationsPKB();
}Future<void> startPollingNotificationsPKBTUTUP() async {
  await API.showBookingNotificationsPKBTUTUP();
}Future<void> startPollingNotificationsDikerjakan() async {
  await API.showBookingNotificationsSelesaiDikerjakan();
}Future<void> startPollingNotificationsInvoice() async {
  await API.showBookingNotificationsInvoice();
}Future<void> startPollingNotificationsLunas() async {
  await API.showBookingNotificationsLunas();
}Future<void> startPollingNotificationsDitolak() async {
  await API.showBookingNotificationsDitolak();
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
