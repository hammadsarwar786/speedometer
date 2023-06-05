import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class test extends StatefulWidget {
  test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade500,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 200,
                  backgroundColor: Colors.black.withOpacity(0.9),
                  child: Container(
                    height: 250,
                    width: 250,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 300,
                          interval: 20,
                          tickOffset: -35,
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
                                  Color.fromARGB(255, 101, 182, 67),
                                  Color.fromARGB(255, 55, 208, 47),
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
                              value: 30,
                              markerHeight: 50,
                              markerOffset: -20,
                              borderColor: Color.fromARGB(255, 147, 184, 214),
                              borderWidth: 1,
                              markerType: MarkerType.triangle,
                            ),
                          ],
                          // annotations: <GaugeAnnotation>[
                          //   GaugeAnnotation(
                          //       horizontalAlignment: GaugeAlignment.center,
                          //       verticalAlignment: GaugeAlignment.center,
                          //       widget: Container(
                          //         child: Text(
                          //           '150',
                          //           style: TextStyle(
                          //               fontSize: 70, fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       angle: 250,
                          //       positionFactor: 0.5),
                          // ],
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 400,
                    width: 200,
                    child: Center(
                        child: Text(
                      "700",
                      style: TextStyle(
                        color: Color.fromARGB(255, 132, 255, 0),
                        fontSize: 110,
                        fontFamily: "Two",
                        letterSpacing: 4,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
