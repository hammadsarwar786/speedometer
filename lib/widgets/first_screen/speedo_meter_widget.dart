import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../providers/speedprovider.dart';

class speedo_meter_widget extends StatefulWidget {
  const speedo_meter_widget({super.key});

  @override
  State<speedo_meter_widget> createState() => _speedo_meter_widgetState();
}

class _speedo_meter_widgetState extends State<speedo_meter_widget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpeedNotificationProvider>(context);
    //
    return ChangeNotifierProvider(
      create: (_) => SpeedNotificationProvider(),
      child: Consumer<SpeedNotificationProvider>(
        builder: (context, spped, _) {
          double speed = spped.currentSpeed;
          return Stack(
            children: [
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 300,
                    interval: 20,
                    tickOffset: -35,
                    radiusFactor: 0.65,
                    minorTickStyle: MinorTickStyle(
                      color: Colors.blue,
                    ),
                    majorTickStyle: MajorTickStyle(
                      color: Color.fromARGB(255, 183, 255, 0),
                    ),
                    labelOffset: -20,
                    axisLabelStyle: GaugeTextStyle(
                      color: Colors.white,
                    ),
                    labelsPosition: ElementsPosition.inside,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 300,
                        color: Colors.white,
                        gradient: SweepGradient(
                          colors: const <Color>[
                            Color.fromARGB(0, 102, 182, 67),
                            Color.fromARGB(0, 55, 208, 47),
                            Color.fromARGB(255, 201, 46, 46),
                            Color.fromARGB(255, 227, 26, 26),
                          ],
                          stops: const <double>[
                            0,
                            0.2722222,
                            0.5833333,
                            0.777777,
                          ],
                        ),
                      ),
                    ],
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        color: Color.fromARGB(255, 113, 174, 225),
                        value: double.parse(
                          provider.isMonitoring
                              ? '${provider.currentSpeed.toStringAsFixed(0)}'
                              : "0",
                        ),
                        // value: double.parse('${speed.toStringAsFixed(1)}'),
                        markerHeight: 50,
                        markerOffset: -20,
                        borderColor: Color.fromARGB(255, 14, 191, 230),
                        borderWidth: 1,
                        markerType: MarkerType.triangle,
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Text(
                  // check == true ? "${(speed * 3).toStringAsFixed(0)}" : "0",
                  provider.isMonitoring
                      ? '${provider.currentSpeed.toStringAsFixed(0)}'
                      : "0",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 221, 255),
                    fontSize: MediaQuery.of(context).size.width / 5,
                    fontFamily: "Two",
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
