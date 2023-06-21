import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/speedprovider.dart';

class map_screen extends StatefulWidget {
  const map_screen({super.key});

  @override
  State<map_screen> createState() => _map_screenState();
}

class _map_screenState extends State<map_screen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpeedNotificationProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMap(
                                gestureRecognizers:
                                    <Factory<OneSequenceGestureRecognizer>>[
                                  new Factory<OneSequenceGestureRecognizer>(
                                    () => new EagerGestureRecognizer(),
                                  ),
                                ].toSet(),
                                compassEnabled: true,
                                myLocationEnabled: true,
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    123123.123,
                                    123123.123,
                                  ),
                                  zoom: 12.0,
                                ),
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(138, 0, 0, 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            provider.isMonitoring
                                ? '${provider.currentSpeed.toStringAsFixed(0)}'
                                : "0",
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: "Two",
                                color: Color.fromARGB(255, 0, 255, 247)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // : Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         CircularProgressIndicator(
              //           color: Colors.white,
              //         ),
              //       ],
              //     ),
              //   ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.timer_outlined,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Duration",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Text(
                                      provider.isMonitoring
                                          ? '${provider.timerValue}'
                                          : "00:00:00",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 213, 255),
                                        fontFamily: "Two",
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.time_to_leave,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Distance",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Text(
                                      provider.isMonitoring
                                          ? "${provider.totalDistance.toStringAsFixed(0)}"
                                          : "0",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 213, 255),
                                        fontFamily: "Two",
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.flag_circle_sharp,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Avg.Speed",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Text(
                                      provider.isMonitoring
                                          ? '${(provider.maxspeed / 2).toStringAsFixed(0)}'
                                          : "0",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 213, 255),
                                        fontFamily: "Two",
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.speed,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Max.Speed",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      provider.isMonitoring
                                          ? '${provider.maxspeed.toStringAsFixed(0)}'
                                          : "0",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 213, 255),
                                        fontFamily: "Two",
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          if (provider.isMonitoring) {
                            provider.stopMonitoring();
                            //timer
                            Provider.of<SpeedNotificationProvider>(context,
                                    listen: false)
                                .stop();
                            //distance
                            Provider.of<SpeedNotificationProvider>(context,
                                    listen: false)
                                .startTracking();
                          } else {
                            provider.startMonitoring();
                            //timer
                            Provider.of<SpeedNotificationProvider>(context,
                                    listen: false)
                                .start();
                            //distance
                            Provider.of<SpeedNotificationProvider>(context,
                                    listen: false)
                                .startTracking();
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 229, 255),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                provider.isMonitoring
                                    ? Icons.stop
                                    : Icons.play_arrow,
                                color: Colors.black,
                                size: 28,
                              ),
                              Text(
                                provider.isMonitoring ? "STOP" : "START",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
