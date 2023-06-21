import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SpeedNotificationProvider with ChangeNotifier {
  double _currentSpeed = 0.0;
  bool _isMonitoring = false;
  //max and avg
  double max_speed = 0.0;
  bool _isGpsConnected = false;

  Timer? _timer;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  // distance
  double _totalDistance = 0;
  Position? _previousPosition;
  double get totalDistance => _totalDistance;

  double get currentSpeed => _currentSpeed;
  double get maxspeed => max_speed;
  bool get isMonitoring => _isMonitoring;
  bool get isGpsConnected => _isGpsConnected;

  String get timerValue {
    String digitSeconds = (_seconds >= 10) ? "$_seconds" : "0$_seconds";
    String digitMinutes = (_minutes >= 10) ? "$_minutes" : "0$_minutes";
    String digitHours = (_hours >= 10) ? "$_hours" : "0$_hours";
    return "$digitHours:$digitMinutes:$digitSeconds";
  }
  // speed

  SpeedNotificationProvider() {
    startSpeedUpdates();
  }

  Future<void> startSpeedUpdates() async {
    StreamSubscription<Position> positionStream;
    PermissionStatus permissionStatus =
        await Permission.locationWhenInUse.status;
    await GoogleApiAvailability.instance.makeGooglePlayServicesAvailable();
    if (permissionStatus.isGranted) {
      positionStream = Geolocator.getPositionStream(
              
              locationSettings:
                  LocationSettings(accuracy: LocationAccuracy.low))
          .listen((Position position) async {
        double speed = position.speed;
        bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();

        if (speed != null) {
          _currentSpeed = speed;

          _isGpsConnected = isGpsEnabled;
          if (speed > max_speed) {
            max_speed = speed;
          }
          notifyListeners();
        }
      });
    } else if (permissionStatus.isDenied) {
      // Handle case where user denied permission
      PermissionStatus newPermissionStatus =
          await Permission.locationWhenInUse.request();
      if (newPermissionStatus.isGranted) {
        startSpeedUpdates(); // Retry starting speed updates
      } else {
        // Permission still denied, handle accordingly
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      // Handle case where user permanently denied permission
      // You can prompt the user to go to settings and enable the permission manually
    }
  }

  void stopSpeedUpdates() {
    // Stop listening to position updates
    // This can be called when you want to stop tracking the speed
  }

  void start() {
    _timer?.cancel(); // Cancel the previous timer if it exists
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++; // Increment seconds

      if (_seconds >= 60) {
        _seconds = 0;
        _minutes++; // Increment minutes

        if (_minutes >= 60) {
          _minutes = 0;
          _hours++; // Increment hours
        }
      }

      notifyListeners(); // Notify listeners about the timer value change
    });
  }

  void startTracking() {
    Geolocator.getPositionStream(
            locationSettings: LocationSettings(accuracy: LocationAccuracy.low, ))
        .listen((Position position) {
      if (_previousPosition != null) {
        final double distance = Geolocator.distanceBetween(
          _previousPosition!.latitude,
          _previousPosition!.longitude,
          position.latitude,
          position.longitude,
        );

        _totalDistance += distance / 1000;
        notifyListeners();
      }

      _previousPosition = position;
    });
  }

  void stopTracking() {
    _previousPosition = null;
    _totalDistance = 0;
    //
    _currentSpeed = 0.0;
    max_speed = 0.0;
    _previousPosition = null;
    _totalDistance = 0;
    notifyListeners();
  }

  void stop() {
    _timer?.cancel(); // Stop the timer
    _seconds = 0; // Reset timer values
    _minutes = 0;
    _hours = 0;
    notifyListeners(); // Notify listeners about the timer value change
  }

  void startMonitoring() {
    _isMonitoring = true;
    notifyListeners();
  }

  void stopMonitoring() {
    _isMonitoring = false;
    _currentSpeed = 0.0;
    max_speed = 0.0;
    _previousPosition = null;
    _totalDistance = 0;
    stop();
    notifyListeners();
  }
}
