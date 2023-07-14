import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:speedometer/providers/speedprovider.dart';
import 'package:speedometer/screens/homescreen.dart';
import 'package:permission_handler/permission_handler.dart';

// Hammad Daddy

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SpeedNotificationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
      ),
      title: 'Speed Notification Demo',
      debugShowCheckedModeBanner: false,
      home: homescreen(),
    );
  }
}
