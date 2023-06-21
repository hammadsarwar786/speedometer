import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../providers/speedprovider.dart';

class digital_screen extends StatefulWidget {
  const digital_screen({super.key});

  @override
  State<digital_screen> createState() => _digital_screenState();
}

class _digital_screenState extends State<digital_screen> {
  //
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpeedNotificationProvider>(context);

    return ChangeNotifierProvider(
        create: (_) => SpeedNotificationProvider(),
        child:
            Consumer<SpeedNotificationProvider>(builder: (context, spped, _) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 19, 18, 18),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Text(
                              provider.isMonitoring
                                  ? '${provider.currentSpeed.toStringAsFixed(0)}'
                                  : "0",
                              // check == true ? "${speed.toStringAsFixed(0)}" : "0",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 221, 255),
                                fontSize: MediaQuery.of(context).size.width / 2,
                                fontFamily: "Two",
                              ),
                            ),
                          ),
                          Text(
                            "Km/h",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 225, 255),
                            ),
                          )
                        ],
                      ),
                    ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          Text(
                                            provider.isMonitoring
                                                ? '${provider.timerValue}'
                                                : "00:00:00",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 213, 255),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          Text(
                                            provider.isMonitoring
                                                ? "${provider.totalDistance.toStringAsFixed(0)}"
                                                : "0",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 213, 255),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          Text(
                                            provider.isMonitoring
                                                ? '${(provider.maxspeed / 2).toStringAsFixed(0)}'
                                                : "0",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 213, 255),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                style: TextStyle(
                                                    color: Colors.white),
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
                                              color: Color.fromARGB(
                                                  255, 0, 213, 255),
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
                                  Provider.of<SpeedNotificationProvider>(
                                          context,
                                          listen: false)
                                      .stop();
                                  //distance
                                  Provider.of<SpeedNotificationProvider>(
                                          context,
                                          listen: false)
                                      .startTracking();
                                } else {
                                  provider.startMonitoring();
                                  //timer
                                  Provider.of<SpeedNotificationProvider>(
                                          context,
                                          listen: false)
                                      .start();
                                  //distance
                                  Provider.of<SpeedNotificationProvider>(
                                          context,
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
                ],
              ),
            ),
          );
        }));
  }
}
