import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'app/componen/color.dart';
import 'app/data/endpoint.dart';
import 'app/data/publik.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
  // await API.showBookingNotificationsApprove();


  runApp(const MyApp());
}

void startPollingNotifications() {
  const pollingInterval = Duration(minutes: 1);

  Timer.periodic(pollingInterval, (timer) async {
    print("Polling notification...");
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _token;
  late PusherChannelsFlutter pusher;
  final String appId = "1827229";
  final String key = "5c463cc9a2fdf08932b5";
  final String secret = "521202e4d68dc816c054";
  final String cluster = "ap1";

  @override
  void initState() {
    super.initState();
    initPusher();
    _getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
        apiKey: key,
        cluster: cluster,
        onEvent: (event) {
          print("Event received: $event");
          showLocalNotification(event.eventName, event.data);
        },
        onConnectionStateChange: (currentState, previousState) {
          print("Connection state changed from $previousState to $currentState");
        },
        onError: (message, code, exception) {
          print("Connection error: $message");
        },
      );
      await pusher.connect();
      await pusher.subscribe(
        channelName: 'my-channel',
      );
    } catch (e) {
      print("Pusher connection error: $e");
    }
  }

  void _getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      setState(() {
        _token = token;
      });
      print("FCM Token: $_token");

      // Subscribe to topic
      messaging.subscribeToTopic('ValeBooking').then((_) {
        print('Subscribed to allUsers topic');
      }).catchError((error) {
        print('Failed to subscribe to allUsers topic: $error');
      });
    } else {
      print("User declined or has not accepted permission");
    }
  }

  void showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'high_importance_channel', // channel_id
      'High Importance Notifications', // channel_name
      channelDescription: 'This channel is used for important notifications.', // channel_description
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      showWhen: false,
      sound: RawResourceAndroidNotificationSound('sounds'),
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notikasi Masuk',
      'Status Kendaraan anada : Booking',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

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
