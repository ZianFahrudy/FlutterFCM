// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm/pages/home_page.dart';
import 'package:flutter_fcm/pages/notification_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // handle when on click and on foreground notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeName = message.data['route'];

        Navigator.of(context).pushNamed(routeName);
      }
    });

    // handle when on click and on foreground notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('ziannnnn');
    });

    // handle when on foreground notification
    FirebaseMessaging.onMessage.listen((message) {
      print(message);

      if (message.notification != null) {
        print(message.notification!.title);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/notif-page': (_) => const NotificationPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
