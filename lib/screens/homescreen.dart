import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:speedometer/widgets/first_screen/speedo_meterscreen.dart';
import 'package:speedometer/widgets/second_screen/digital_screen.dart';
import 'package:speedometer/widgets/third_screen/map_screen.dart';

import '../providers/speedprovider.dart';

class homescreen extends StatefulWidget {
  homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> with TickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpeedNotificationProvider>(context);

    return ChangeNotifierProvider(
        create: (_) => SpeedNotificationProvider(),
        child:
            Consumer<SpeedNotificationProvider>(builder: (context, speed, _) {
          bool gps = provider.isGpsConnected;

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              toolbarHeight: 55,
              bottom: TabBar(
                controller: _controller,
                labelColor: Color.fromARGB(255, 0, 255, 242),
                tabs: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Gauge",
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Digital",
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Map",
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Speedometer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.signal_cellular_alt,
                              size: 16,
                              color: gps
                                  ? const Color.fromARGB(255, 35, 220, 41)
                                  : Color.fromARGB(255, 255, 0, 0),
                            ),
                            Text(
                              "GPS",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.crop_rotate_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              children: [
                speedometerscreen(),
                digital_screen(),
                map_screen(),
              ],
            ),
          );
        }));
  }
}
