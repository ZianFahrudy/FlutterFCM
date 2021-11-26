// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm/pages/home_page.dart';
import 'package:flutter_fcm/pages/notification_page.dart';
import 'package:get/get.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // handle when on click and on terminated notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeName = message.data['route'];

        Navigator.of(context).pushNamed(routeName);
      }
    });

    // handle when on click and on background notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification!.title);
    });

    // handle when on foreground notification
    FirebaseMessaging.onMessage.listen((message) {
      print(message);

      if (message.notification != null) {
        InAppNotifications.show(
            title: message.notification!.title,
            leading: const Icon(
              Icons.fact_check,
              color: Colors.green,
              size: 50,
            ),
            duration: const Duration(seconds: 15),
            ending: const Icon(
              Icons.arrow_right_alt,
              color: Colors.red,
            ),
            description: message.notification!.body,
            onTap: () {
              Get.to<void>(() => const NotificationPage());
            });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/notif-page': (_) => const NotificationPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
      builder: InAppNotifications.init(),
    );
  }
}
