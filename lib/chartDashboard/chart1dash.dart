// ignore_for_file: camel_case_types
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as chart;
import 'dart:math' as math;
import 'package:mop_green/shared/shared.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:intl/intl.dart';

import '../pages/MqttConnectionChart.dart';

class room1 extends StatefulWidget {
  const room1({Key? key}) : super(key: key);

  @override
  State<room1> createState() => _room1State();
}

class _room1State extends State<room1> {
  List<LiveData> chartData = <LiveData>[
    LiveData(0, 0),
    LiveData(1, 0),
    LiveData(2, 0),
    LiveData(3, 0),
    LiveData(4, 0),
    LiveData(5, 0),
    LiveData(6, 0),
    LiveData(7, 0),
    LiveData(8, 0),
    LiveData(9, 0),
    LiveData(10, 0),
    LiveData(11, 0),
    LiveData(12, 0),
    LiveData(13, 0),
    LiveData(14, 0),
    LiveData(15, 0),
    LiveData(16, 0),
    LiveData(17, 0),
    LiveData(18, 0),
  ];
  List<LiveData> chartData1 = <LiveData>[
    LiveData(0, 0),
    LiveData(1, 0),
    LiveData(2, 0),
    LiveData(3, 0),
    LiveData(4, 0),
    LiveData(5, 0),
    LiveData(6, 0),
    LiveData(7, 0),
    LiveData(8, 0),
    LiveData(9, 0),
    LiveData(10, 0),
    LiveData(11, 0),
    LiveData(12, 0),
    LiveData(13, 0),
    LiveData(14, 0),
    LiveData(15, 0),
    LiveData(16, 0),
    LiveData(17, 0),
    LiveData(18, 0),
  ];
  MQTTClientManagerChart mqttClientManager = MQTTClientManagerChart();
  late chart.ChartSeriesController _chartSeriesController;
  late chart.ChartSeriesController _chartSeriesController1;
  int time = 19;

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe("sensor");
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = jsonDecode(
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message));
      updateDataSource(pt["humadity1"], pt["temp1"]);
    });
  }

  @override
  void initState() {
    setupMqttClient().then((value) {
      setupUpdatesListener();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: 327,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Room',
                    style: meTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Image.asset('assets/images/divider.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Suhu',
                    style: meTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/images/divider1.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Kelembapan',
                    style: meTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            //*Ini Kodingan Chartnya
            chart.SfCartesianChart(
              series: <chart.LineSeries<LiveData, int>>[
                chart.LineSeries<LiveData, int>(
                    onRendererCreated:
                        (chart.ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    dataSource: chartData,
                    color: Colors.blue,
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.speed),
                chart.LineSeries<LiveData, int>(
                    onRendererCreated:
                        (chart.ChartSeriesController controller) {
                      _chartSeriesController1 = controller;
                    },
                    dataSource: chartData1,
                    color: Colors.red,
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.speed),
              ],
              primaryXAxis: chart.NumericAxis(
                  majorGridLines: const chart.MajorGridLines(width: 0),
                  edgeLabelPlacement: chart.EdgeLabelPlacement.shift,
                  interval: 1,
                  title: chart.AxisTitle(
                      text: DateFormat('E d MMMM, yyyy ??? kk:mm:ss')
                          .format(DateTime.now()))),
              primaryYAxis: chart.NumericAxis(
                axisLine: const chart.AxisLine(width: 0),
                majorTickLines: const chart.MajorTickLines(size: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateDataSource(int value, int value2) {
    chartData.add(LiveData(time++, value));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
    chartData1.add(LiveData(time++, value2));
    chartData1.removeAt(0);
    _chartSeriesController1.updateDataSource(
        addedDataIndex: chartData1.length - 1, removedDataIndex: 0);
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}

class LiveData1 {
  LiveData1(this.time, this.speed);
  final int time;
  final num speed;
}
