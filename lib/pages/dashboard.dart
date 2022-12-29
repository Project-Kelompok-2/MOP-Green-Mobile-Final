// ignore_for_file: camel_case_types

part of 'pages.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

// class MqttService{
//    MqttService._();

//   /// Our mqtt client object.
//   static late MqttClient client;

//   // for listen from other pages.
//   // and can close listen mqtt.
//   static StreamSubscription? mqttListen;

//   static void initMqtt(){

//     /// Initialize Mqtt and connect.
//     client = MqttServerClient('20.20.0.245', 'mobile')
//         ..logging(on: false)
//         ..port = MqttConstants.mqttPort
//         ..keepAlivePeriod = 20
//         ..onDisconnected = _onDisconnected
//         ..onSubscribed = _onSubscribed
//         ..onConnected = _onConnected
//         ..onUnsubscribed = _onUnsubscribed
//         ..onSubscribeFail = _onSubscribeFail;

//      /// If the mqtt connection lost
//      /// MqttBroker publish this message on this topic.
//      final mqttMsg = MqttConnectMessage()
//         .withWillMessage('connection-failed')
//         .withWillTopic('willTopic')
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce)
//         .withWillTopic('failed');
//     client.connectionMessage = mqttMsg;
//     await _connectMqtt();
//   }

//    /// Mqtt server connected.
//   void _onConnected() {
//     log('Connected');
//     _listenMqtt();
//   }

//   /// Mqtt server disconnected
//   void _onDisconnected() {
//     log('Disconnected');
//   }

//   /// Mqtt server subscribed
//   void _onSubscribed(String? topic) {
//     log('Subscribed topic is : $topic');
//   }

//   void _onUnsubscribed(String? topic) {
//     log('Unsubscribed topic is : $topic');
//   }

//   void _onSubscribeFail(String? topic) {
//     log('Failed subscribe topic : $topic');
//   }

//   /// Connection MQTT Server.
//   Future<void> _connectMqtt() async {
//     if (client.connectionStatus!.state != MqttConnectionState.connected) {
//       try {
//         await client.connect();
//       } catch (e) {
//         log('Connection failed' + e.toString());
//       }
//     } else {
//       log('MQTT Server already connected ');
//     }
//   }

//   /// Diconnection MQTT Server.
//   static Future<void> disconnectMqtt() async {
//     if (client.connectionStatus!.state == MqttConnectionState.connected) {
//       try {
//         client.disconnect();
//       } catch (e) {
//         log('Disconnection Failed ' + e.toString());
//       }
//     } else {
//       log('MQTT Server already disconnected ');
//     }
//   }

//   /// Subscribe a topic
//   static void subscribeTopic(String topic) {
//     final state = client.connectionStatus?.state;
//     if (state != null) {
//       if (state == MqttConnectionState.connected) {
//         client.subscribe(topic + "/data", MqttQos.atLeastOnce);
//       }
//     }
//   }

//   /// Publish a message to topic
//   /// [reatain] means last message save the broker.
//   static void publish(String topic, String message, {bool retain = true}) {
//     final builder = MqttClientPayloadBuilder();
//     builder.addString(message);
//     client.publishMessage(
//       topic,
//       MqttQos.atLeastOnce,
//       builder.payload!,
//       retain: retain,
//     );
//     builder.clear();
//   }

//   static void unSubscribeTopic(String topic) {
//     final state = client.connectionStatus?.state;
//     if (state != null) {
//       if (state == MqttConnectionState.connected) {
//         client.unsubscribe(topic + "/data");
//       }
//     }
//   }

//   static void onClose(){
//     mqttListen?.close();
//     disconnectMqtt();
//   }

//   void _listenMqtt() {
//     mqttListen = client.updates!.listen((dynamic t) {
//       MqttPublishMessage recMessage = t[0].payload;
//       final message =
//           MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);
//       /*
//         Listen subscribe topic.
//       */
//       log(message);
//     });
//   }

// }

// enum MQTTAppConnectionState { connected, disconnected, connecting }

// class MQTTManager {
//   // Private instance of client
//   MQTTAppConnectionState _currentState = MQTTAppConnectionState.disconnected;
//   MqttServerClient? _client;
//   final String _identifier = 'mobile_client';
//   final String _host = '20.20.0.245';
//   final String _topic = 'sensor';

//   void initializeMQTTClient() {
//     _client = MqttServerClient(_host, _identifier);
//     _client?.setProtocolV311();
//     _client?.port = 9001;
//     _client?.keepAlivePeriod = 60;
//     _client?.onDisconnected = onDisconnected;
//     _client?.logging(on: true);
//     _client?.onConnected = onConnected;
//     _client?.onSubscribed = onSubscribed;

//     final MqttConnectMessage connMess = MqttConnectMessage()
//         .withClientIdentifier(_identifier)
//         .withWillTopic('willTopic')
//         .withWillMessage('My Will message')
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce);
//     _client?.connectionMessage = connMess;
//     print('Initialize::Mosquitto client connecting....');
//   }

//   void connect() async {
//     try {
//       await _client?.connect();
//     } on NoConnectionException catch (e) {
//       print('Connect::client exception - $e');
//       disconnect();
//     } on SocketException catch (e) {
//       print('Connect::socket exception - $e');
//       disconnect();
//     }

//     if (_client?.connectionStatus!.state == MqttConnectionState.connected) {
//       print('Connect::Mosquitto client connected');
//     } else {
//       print(
//           'Connect::ERROR Mosquitto client connection failed - disconnecting, status is ${_client?.connectionStatus}');
//       disconnect();
//     }
//   }

//   void disconnect() {
//     print('Disconnect::Mosquitto client Disconnecting...');
//     _client?.disconnect();
//   }

//   void publish(String message) {
//     final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
//     builder.addString(message);
//     _client?.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
//     print('Publish::The Message published');
//   }

//   void onSubscribed(String topic) {
//     print('onSubscribed::Subscription confirmed for topic $topic');
//   }

//   void onDisconnected() {
//     print(
//         'onDisconnected::OnDisconnected client callback - Client disconnection');
//     if (_client?.connectionStatus?.disconnectionOrigin ==
//         MqttDisconnectionOrigin.solicited) {
//       print(
//           'onDisconnected::OnDisconnected callback is solicited, this is correct');
//     } else {
//       print(
//           'onDisconnected::OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
//       print(_client?.connectionStatus?.disconnectionOrigin);
//     }
//   }

//   void onConnected() {
//     print('onConnected::Mosquitto client connected');
//     publish('test-message');
//   }
// }

// class RealData extends StatefulWidget {
//   const RealData({super.key});

//   @override
//   State<RealData> createState() => _RealDataState();
// }

// class _RealDataState extends State {
//   String _suhu = "0";
//   String _kelembapan = "0";

//   @override
//   Widget build(BuildContext context) {
//           setState(() {
//             _suhu == "";
//             _kelembapan == "";
//   });

//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

// class _RealDataState extends State<RealData> {
//   String _suhu = "";
//   String _kelembapan = "";

//   void _handRealData(String _suhu, String _kelembapan) {
//     setState(() {
//       _suhu = _suhu;
//       _kelembapan = _kelembapan;
//     });
//   }

//   @override
//   dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }

class _dashboardState extends State<dashboard> {
  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(pubTopic);
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');

      setState(() {
        suhu = jsonDecode(pt)["temp1"];
        kelembapan = jsonDecode(pt)["humadity1"];
      });
    });
  }

  // int dropdownIndex = 0;
  // List data = [
  //   const room1(),
  //   const room2(),
  //   const room3(),
  //   const room4(),
  // ];

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }

  // late List<LiveData> chartData;
  // late List<LiveData> chartData2;
  // late List<LiveData> chartData3;
  // late List<LiveData> chartData4;
  // late List<LiveData> chartData5;
  // late List<LiveData> chartData6;
  // late List<LiveData> chartData7;
  // late List<LiveData> chartData8;
  // late chart.ChartSeriesController _chartSeriesController;
  // late chart.ChartSeriesController _chartSeriesController2;
  // late chart.ChartSeriesController _chartSeriesController3;
  // late chart.ChartSeriesController _chartSeriesController4;
  // late chart.ChartSeriesController _chartSeriesController5;
  // late chart.ChartSeriesController _chartSeriesController6;
  // late chart.ChartSeriesController _chartSeriesController7;
  // late chart.ChartSeriesController _chartSeriesController8;
  int suhu = 0;
  int kelembapan = 0;
  String pubTopic = "sensor";

  //import class mqtt
  MQTTClientManager mqttClientManager = MQTTClientManager();

  @override
  void initState() {
    setupMqttClient();
    setupUpdatesListener();
    super.initState();
    // manager.connect();
    //  MQTTManager._client.connect();
    // connect(
    //     onConnected: () {
    //       print("Connected");
    //     },
    //     onDisconnected: () {
    //       print("Disconnected from server");
    //     },
    //     onSubscribed: (String) {
    //       // MqttServerClient.withPort('1883');
    //       print("Succcess subscribe");
    //     },
    //     onUnsubscribed: (String) {}
    //     // print("gagal subscribe");
    //     );
    // chartData = getChartData();
    // chartData2 = getChartData2();
    // chartData3 = getChartData3();
    // chartData4 = getChartData4();
    // chartData5 = getChartData5();
    // chartData6 = getChartData6();
    // chartData7 = getChartData7();
    // chartData8 = getChartData8();
    // Timer.periodic(const Duration(minutes: 1), updateDataSource);
    super.initState();
  }

  //!Body
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F2F4),
        body: Column(
          children: [
            Container(
              width: 414,
              height: 363,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF16D682), Color(0xFF05BE5E)]),
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Room 1',
                      style: selamatdatangTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //!Grafik Suhu
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 121,
                                    height: 121,
                                    child: SfRadialGauge(
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          axisLineStyle: const AxisLineStyle(
                                            thickness: 0.2,
                                            thicknessUnit: GaugeSizeUnit.factor,
                                            cornerStyle: CornerStyle.bothCurve,
                                          ),
                                          showTicks: false,
                                          showLabels: false,
                                          onAxisTapped: (value) {},
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                              color: Colors.white,
                                              value: suhu.toDouble(),
                                              onValueChanged: (value) {},
                                              cornerStyle:
                                                  CornerStyle.bothCurve,
                                              onValueChangeEnd: (value) {},
                                              onValueChangeStart: (value) {},
                                              enableDragging: true,
                                              width: 0.2,
                                              sizeUnit: GaugeSizeUnit.factor,
                                            ),
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              widget: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    suhu.toString(),
                                                    style: wikwokTextStyle,
                                                  ),
                                                  Text(
                                                    "suhu",
                                                    style: meTextStyle,
                                                  )
                                                ],
                                              ),
                                              positionFactor: 0.13,
                                              angle: 0.5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Rata-rata Suhu",
                                    style: meTextStyle,
                                  ),
                                  Text(
                                    "23",
                                    style: wikwokTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Suhu Tertinggi",
                                    style: meTextStyle,
                                  ),
                                  Text(
                                    "28",
                                    style: wikwokTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Suhu Terendah",
                                    style: meTextStyle,
                                  ),
                                  Text(
                                    "21",
                                    style: wikwokTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //! Grafik Kelembapan
                        Expanded(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 121,
                                    height: 121,
                                    child: SfRadialGauge(
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          axisLineStyle: const AxisLineStyle(
                                            thickness: 0.2,
                                            thicknessUnit: GaugeSizeUnit.factor,
                                            cornerStyle: CornerStyle.bothCurve,
                                          ),
                                          showTicks: false,
                                          showLabels: false,
                                          onAxisTapped: (value) {},
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                              color: Colors.white,
                                              value: kelembapan.toDouble(),
                                              onValueChanged: (value) {},
                                              cornerStyle:
                                                  CornerStyle.bothCurve,
                                              onValueChangeEnd: (value) {},
                                              onValueChangeStart: (value) {},
                                              enableDragging: true,
                                              width: 0.2,
                                              sizeUnit: GaugeSizeUnit.factor,
                                            ),
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              widget: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    kelembapan.toString(),
                                                    style: wikwokTextStyle,
                                                  ),
                                                  Text(
                                                    "Kelembapan",
                                                    style: meTextStyle.copyWith(
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              positionFactor: 0.13,
                                              angle: 0.5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Rata-rata Kelembapan",
                                    style: meTextStyle,
                                  ),
                                  Text(
                                    "68",
                                    style: wikwokTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Kelembapan Tertinggi",
                                    style: meTextStyle,
                                  ),
                                  Text(
                                    "74",
                                    style: wikwokTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Kelembapan Terendah",
                                    style: meTextStyle,
                                  ),
                                  Text(
                                    "65",
                                    style: wikwokTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    children: [
                      room1()
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 90),
                      //   child: Card(
                      //     child: DropdownSearch<dynamic>(
                      //       popupProps: const PopupProps.menu(
                      //         fit: FlexFit.loose,
                      //       ),
                      //       items: const [
                      //         "Room chart 1",
                      //         "Room chart 2",
                      //         "Room chart 3",
                      //         "Room chart 4"
                      //       ],
                      //       dropdownDecoratorProps: const DropDownDecoratorProps(
                      //         dropdownSearchDecoration: InputDecoration(
                      //           contentPadding: EdgeInsets.all(10),
                      //           labelText: "Pilih Room",
                      //         ),
                      //       ),
                      //       onChanged: (o) {
                      //         setState(() {
                      //           switch (o) {
                      //             case "Room chart 1":
                      //               dropdownIndex = 0;
                      //               break;
                      //             case "Room chart 2":
                      //               dropdownIndex = 1;
                      //               break;
                      //             case "Room chart 3":
                      //               dropdownIndex = 2;
                      //               break;
                      //             case "Room chart 4":
                      //               dropdownIndex = 3;
                      //               break;
                      //             default:
                      //               dropdownIndex = 0;
                      //               break;
                      //           }
                      //         });
                      //       },
                      //       selectedItem: data[dropdownIndex],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // data[dropdownIndex],
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 19,
            // ),
            //!Scrollview
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 3),
            //       child: Column(
            //         children: [
            //           //!Chart Room 1
            //           // Card(
            //           //   child: Container(
            //           //     width: double.infinity,
            //           //     height: 327,
            //           //     color: Colors.white,
            //           //     child: Column(
            //           //       children: [
            //           //         Padding(
            //           //           padding: const EdgeInsets.all(5),
            //           //           child: Row(
            //           //             mainAxisAlignment: MainAxisAlignment.start,
            //           //             children: [
            //           //               Text(
            //           //                 'Room 1',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //               const Spacer(),
            //           //               Image.asset('assets/images/divider.png'),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Text(
            //           //                 'Suhu',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Image.asset('assets/images/divider1.png'),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Text(
            //           //                 'Kelembapan',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //             ],
            //           //           ),
            //           //         ),
            //           //         //*Ini Kodingan Chartnya
            //           //         // chart.SfCartesianChart(
            //           //         //   series: <chart.LineSeries<LiveData, int>>[
            //           //         //     chart.LineSeries<LiveData, int>(
            //           //         //         onRendererCreated:
            //           //         //             (chart.ChartSeriesController
            //           //         //                 controller) {
            //           //         //           _chartSeriesController = controller;
            //           //         //         },
            //           //         //         dataSource: chartData,
            //           //         //         color: Colors.blue,
            //           //         //         xValueMapper: (LiveData sales, _) =>
            //           //         //             sales.time,
            //           //         //         yValueMapper: (LiveData sales, _) =>
            //           //         //             sales.speed),
            //           //         //     chart.LineSeries<LiveData, int>(
            //           //         //         onRendererCreated:
            //           //         //             (chart.ChartSeriesController
            //           //         //                 controller) {
            //           //         //           _chartSeriesController2 = controller;
            //           //         //         },
            //           //         //         dataSource: chartData2,
            //           //         //         color: Colors.red,
            //           //         //         xValueMapper: (LiveData sales, _) =>
            //           //         //             sales.time,
            //           //         //         yValueMapper: (LiveData sales, _) =>
            //           //         //             sales.speed),
            //           //         //   ],
            //           //         //   primaryXAxis: chart.NumericAxis(
            //           //         //       majorGridLines:
            //           //         //           const chart.MajorGridLines(width: 0),
            //           //         //       edgeLabelPlacement:
            //           //         //           chart.EdgeLabelPlacement.shift,
            //           //         //       interval: 1,
            //           //         //       title:
            //           //         //           chart.AxisTitle(text: 'time(seconds)')),
            //           //         //   primaryYAxis: chart.NumericAxis(
            //           //         //     axisLine: const chart.AxisLine(width: 0),
            //           //         //     majorTickLines:
            //           //         //         const chart.MajorTickLines(size: 0),
            //           //         //   ),
            //           //         // ),
            //           //       ],
            //           //     ),
            //           //   ),
            //           // ),
            //           const SizedBox(
            //             height: 5,
            //           ),
            //           //*Chart Room 2
            //           // Card(
            //           //   child: Container(
            //           //     width: double.infinity,
            //           //     height: 327,
            //           //     color: Colors.white,
            //           //     child: Column(
            //           //       children: [
            //           //         Padding(
            //           //           padding: const EdgeInsets.all(5),
            //           //           child: Row(
            //           //             mainAxisAlignment: MainAxisAlignment.start,
            //           //             children: [
            //           //               Text(
            //           //                 'Room 2',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //               const Spacer(),
            //           //               Image.asset('assets/images/divider.png'),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Text(
            //           //                 'Suhu',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Image.asset('assets/images/divider1.png'),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Text(
            //           //                 'Kelembapan',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //             ],
            //           //           ),
            //           //         ),
            //           //         //!Ini Kodingan Chartnya
            //           //         // chart.SfCartesianChart(
            //           //         //   series: <chart.LineSeries<LiveData, int>>[
            //           //         //     chart.LineSeries<LiveData, int>(
            //           //         //         onRendererCreated:
            //           //         //             (chart.ChartSeriesController
            //           //         //                 controller) {
            //           //         //           _chartSeriesController3 = controller;
            //           //         //         },
            //           //         //         dataSource: chartData3,
            //           //         //         color: Colors.blue,
            //           //         //         xValueMapper: (LiveData sales, _) =>
            //           //         //             sales.time,
            //           //         //         yValueMapper: (LiveData sales, _) =>
            //           //         //             sales.speed),
            //           //         //     chart.LineSeries<LiveData, int>(
            //           //         //         onRendererCreated:
            //           //         //             (chart.ChartSeriesController
            //           //         //                 controller) {
            //           //         //           _chartSeriesController4 = controller;
            //           //         //         },
            //           //         //         dataSource: chartData4,
            //           //         //         color: Colors.red,
            //           //         //         xValueMapper: (LiveData sales, _) =>
            //           //         //             sales.time,
            //           //         //         yValueMapper: (LiveData sales, _) =>
            //           //         //             sales.speed),
            //           //         //   ],
            //           //         //   primaryXAxis: chart.NumericAxis(
            //           //         //       majorGridLines:
            //           //         //           const chart.MajorGridLines(width: 0),
            //           //         //       edgeLabelPlacement:
            //           //         //           chart.EdgeLabelPlacement.shift,
            //           //         //       interval: 1,
            //           //         //       title:
            //           //         //           chart.AxisTitle(text: 'time(seconds)')),
            //           //         //   primaryYAxis: chart.NumericAxis(
            //           //         //     axisLine: const chart.AxisLine(width: 0),
            //           //         //     majorTickLines:
            //           //         //         const chart.MajorTickLines(size: 0),
            //           //         //   ),
            //           //         // ),
            //           //       ],
            //           //     ),
            //           //   ),
            //           // ),
            //           const SizedBox(
            //             height: 5,
            //           ),
            //           //*Chart Room 3
            //           // Card(
            //           //   child: Container(
            //           //     width: double.infinity,
            //           //     height: 327,
            //           //     color: Colors.white,
            //           //     child: Column(
            //           //       children: [
            //           //         Padding(
            //           //           padding: const EdgeInsets.all(5),
            //           //           child: Row(
            //           //             mainAxisAlignment: MainAxisAlignment.start,
            //           //             children: [
            //           //               Text(
            //           //                 'Room 3',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //               const Spacer(),
            //           //               Image.asset('assets/images/divider.png'),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Text(
            //           //                 'Suhu',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Image.asset('assets/images/divider1.png'),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Text(
            //           //                 'Kelembapan',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //             ],
            //           //           ),
            //           //         ),
            //           //         //!Ini kodingan chartnya
            //           //         // chart.SfCartesianChart(
            //           //         //   series: <chart.LineSeries<LiveData, int>>[
            //           //         //     chart.LineSeries<LiveData, int>(
            //           //         //         onRendererCreated:
            //           //         //             (chart.ChartSeriesController
            //           //         //                 controller) {
            //           //         //           _chartSeriesController5 = controller;
            //           //         //         },
            //           //         //         dataSource: chartData5,
            //           //         //         color: Colors.blue,
            //           //         //         xValueMapper: (LiveData sales, _) =>
            //           //         //             sales.time,
            //           //         //         yValueMapper: (LiveData sales, _) =>
            //           //         //             sales.speed),
            //           //         //     chart.LineSeries<LiveData, int>(
            //           //         //         onRendererCreated:
            //           //         //             (chart.ChartSeriesController
            //           //         //                 controller) {
            //           //         //           _chartSeriesController6 = controller;
            //           //         //         },
            //           //         //         dataSource: chartData6,
            //           //         //         color: Colors.red,
            //           //         //         xValueMapper: (LiveData sales, _) =>
            //           //         //             sales.time,
            //           //         //         yValueMapper: (LiveData sales, _) =>
            //           //         //             sales.speed),
            //           //         //   ],
            //           //         //   primaryXAxis: chart.NumericAxis(
            //           //         //       majorGridLines:
            //           //         //           const chart.MajorGridLines(width: 0),
            //           //         //       edgeLabelPlacement:
            //           //         //           chart.EdgeLabelPlacement.shift,
            //           //         //       interval: 1,
            //           //         //       title:
            //           //         //           chart.AxisTitle(text: 'time(seconds)')),
            //           //         //   primaryYAxis: chart.NumericAxis(
            //           //         //     axisLine: const chart.AxisLine(width: 0),
            //           //         //     majorTickLines:
            //           //         //         const chart.MajorTickLines(size: 0),
            //           //         //   ),
            //           //         // ),
            //           //       ],
            //           //     ),
            //           //   ),
            //           // ),
            //           const SizedBox(
            //             height: 5,
            //           ),
            //           //*chart room 4
            //           // Card(
            //           //   child: Container(
            //           //     width: double.infinity,
            //           //     height: 327,
            //           //     color: Colors.white,
            //           //     child: Column(
            //           //       children: [
            //           //         Padding(
            //           //           padding: const EdgeInsets.all(5),
            //           //           child: Row(
            //           //             mainAxisAlignment: MainAxisAlignment.start,
            //           //             children: [
            //           //               Text(
            //           //                 'Room 4',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //               const Spacer(),
            //           //               Image.asset('assets/images/divider.png'),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Text(
            //           //                 'Suhu',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Image.asset('assets/images/divider1.png'),
            //           //               const SizedBox(
            //           //                 width: 10,
            //           //               ),
            //           //               Text(
            //           //                 'Kelembapan',
            //           //                 style: meTextStyle.copyWith(
            //           //                   color: Colors.black,
            //           //                 ),
            //           //               ),
            //           //             ],
            //           //           ),
            //           //         ),
            //           //         //!Ini kodingan chartnya
            //           //         // chart.SfCartesianChart(
            //           //         //   series: <chart.LineSeries<LiveData, int>>[
            //           //         //     chart.LineSeries<LiveData, int>(
            //           //         //         onRendererCreated:
            //           //         //             (chart.ChartSeriesController
            //           //         //                 controller) {
            //           //         //           _chartSeriesController7 = controller;
            //           //         //         },
            //           //         //         dataSource: chartData7,
            //           //         //         color: Colors.blue,
            //           //         //         xValueMapper: (LiveData sales, _) =>
            //           //         //             sales.time,
            //           //         //         yValueMapper: (LiveData sales, _) =>
            //           //         //             sales.speed),
            //           //         //     chart.LineSeries<LiveData, int>(
            //           //         //         onRendererCreated:
            //           //         //             (chart.ChartSeriesController
            //           //         //                 controller) {
            //           //         //           _chartSeriesController8 = controller;
            //           //         //         },
            //           //         //         dataSource: chartData8,
            //           //         //         color: Colors.red,
            //           //         //         xValueMapper: (LiveData sales, _) =>
            //           //         //             sales.time,
            //           //         //         yValueMapper: (LiveData sales, _) =>
            //           //         //             sales.speed),
            //           //         //   ],
            //           //         //   primaryXAxis: chart.NumericAxis(
            //           //         //       majorGridLines:
            //           //         //           const chart.MajorGridLines(width: 0),
            //           //         //       edgeLabelPlacement:
            //           //         //           chart.EdgeLabelPlacement.shift,
            //           //         //       interval: 1,
            //           //         //       title:
            //           //         //           chart.AxisTitle(text: 'time(seconds)')),
            //           //         //   primaryYAxis: chart.NumericAxis(
            //           //         //     axisLine: const chart.AxisLine(width: 0),
            //           //         //     majorTickLines:
            //           //         //         const chart.MajorTickLines(size: 0),
            //           //         //   ),
            //           //         // ),
            //           //       ],
            //           //     ),
            //           //   ),
            //           // ),
            //           const SizedBox(
            //             height: 30,
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text('Warning'),
            content: const Text('Apakah Anda Yakin Ingin Keluar ?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Tidak',
                      style: TextStyle(color: Colors.grey, fontSize: 14))),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    "Iya",
                    style: buttonStyle.copyWith(fontSize: 14),
                  )),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}
  //!Ini buat timer line grafik chartnya
//   int time = 19;
//   void updateDataSource(Timer timer) {
//     chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData.removeAt(0);
//     _chartSeriesController.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//     chartData2.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData2.removeAt(0);
//     _chartSeriesController2.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//     chartData3.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData3.removeAt(0);
//     _chartSeriesController3.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//     chartData4.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData4.removeAt(0);
//     _chartSeriesController4.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//     chartData5.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData5.removeAt(0);
//     _chartSeriesController5.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//     chartData6.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData6.removeAt(0);
//     _chartSeriesController6.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//     chartData7.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData7.removeAt(0);
//     _chartSeriesController7.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//     chartData8.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData8.removeAt(0);
//     _chartSeriesController8.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//   }

//   //!Ini buat data yang diambil chartnya
//   List<LiveData> getChartData() {
//     return <LiveData>[
//       LiveData(0, 42),
//       LiveData(1, 47),
//       LiveData(2, 43),
//       LiveData(3, 49),
//       LiveData(4, 54),
//       LiveData(5, 41),
//       LiveData(6, 58),
//       LiveData(7, 51),
//       LiveData(8, 98),
//       LiveData(9, 41),
//       LiveData(10, 53),
//       LiveData(11, 72),
//       LiveData(12, 86),
//       LiveData(13, 52),
//       LiveData(14, 94),
//       LiveData(15, 92),
//       LiveData(16, 86),
//       LiveData(17, 72),
//       LiveData(18, 94),
//     ];
//   }

//   List<LiveData> getChartData2() {
//     return <LiveData>[
//       LiveData(0, 41),
//       LiveData(1, 45),
//       LiveData(2, 46),
//       LiveData(3, 47),
//       LiveData(4, 31),
//       LiveData(5, 32),
//       LiveData(6, 34),
//       LiveData(7, 30),
//       LiveData(8, 30),
//       LiveData(9, 50),
//       LiveData(10, 51),
//       LiveData(11, 53),
//       LiveData(12, 56),
//       LiveData(13, 44),
//       LiveData(14, 46),
//       LiveData(15, 92),
//       LiveData(16, 95),
//       LiveData(17, 78),
//       LiveData(18, 60),
//     ];
//   }

//   //!Ini buat data yang diambil chartnya
//   List<LiveData> getChartData3() {
//     return <LiveData>[
//       LiveData(0, 42),
//       LiveData(1, 47),
//       LiveData(2, 43),
//       LiveData(3, 49),
//       LiveData(4, 54),
//       LiveData(5, 41),
//       LiveData(6, 58),
//       LiveData(7, 51),
//       LiveData(8, 98),
//       LiveData(9, 41),
//       LiveData(10, 53),
//       LiveData(11, 72),
//       LiveData(12, 86),
//       LiveData(13, 52),
//       LiveData(14, 94),
//       LiveData(15, 92),
//       LiveData(16, 86),
//       LiveData(17, 72),
//       LiveData(18, 94),
//     ];
//   }

//   List<LiveData> getChartData4() {
//     return <LiveData>[
//       LiveData(0, 41),
//       LiveData(1, 45),
//       LiveData(2, 46),
//       LiveData(3, 47),
//       LiveData(4, 31),
//       LiveData(5, 32),
//       LiveData(6, 34),
//       LiveData(7, 30),
//       LiveData(8, 30),
//       LiveData(9, 50),
//       LiveData(10, 51),
//       LiveData(11, 53),
//       LiveData(12, 56),
//       LiveData(13, 44),
//       LiveData(14, 46),
//       LiveData(15, 92),
//       LiveData(16, 95),
//       LiveData(17, 78),
//       LiveData(18, 60),
//     ];
//   }

//   //!Ini buat data yang diambil chartnya
//   List<LiveData> getChartData5() {
//     return <LiveData>[
//       LiveData(0, 42),
//       LiveData(1, 47),
//       LiveData(2, 43),
//       LiveData(3, 49),
//       LiveData(4, 54),
//       LiveData(5, 41),
//       LiveData(6, 58),
//       LiveData(7, 51),
//       LiveData(8, 98),
//       LiveData(9, 41),
//       LiveData(10, 53),
//       LiveData(11, 72),
//       LiveData(12, 86),
//       LiveData(13, 52),
//       LiveData(14, 94),
//       LiveData(15, 92),
//       LiveData(16, 86),
//       LiveData(17, 72),
//       LiveData(18, 94),
//     ];
//   }

//   List<LiveData> getChartData6() {
//     return <LiveData>[
//       LiveData(0, 41),
//       LiveData(1, 45),
//       LiveData(2, 46),
//       LiveData(3, 47),
//       LiveData(4, 31),
//       LiveData(5, 32),
//       LiveData(6, 34),
//       LiveData(7, 30),
//       LiveData(8, 30),
//       LiveData(9, 50),
//       LiveData(10, 51),
//       LiveData(11, 53),
//       LiveData(12, 56),
//       LiveData(13, 44),
//       LiveData(14, 46),
//       LiveData(15, 92),
//       LiveData(16, 95),
//       LiveData(17, 78),
//       LiveData(18, 60),
//     ];
//   }

//   //!Ini buat data yang diambil chartnya
//   List<LiveData> getChartData7() {
//     return <LiveData>[
//       LiveData(0, 42),
//       LiveData(1, 47),
//       LiveData(2, 43),
//       LiveData(3, 49),
//       LiveData(4, 54),
//       LiveData(5, 41),
//       LiveData(6, 58),
//       LiveData(7, 51),
//       LiveData(8, 98),
//       LiveData(9, 41),
//       LiveData(10, 53),
//       LiveData(11, 72),
//       LiveData(12, 86),
//       LiveData(13, 52),
//       LiveData(14, 94),
//       LiveData(15, 92),
//       LiveData(16, 86),
//       LiveData(17, 72),
//       LiveData(18, 94),
//     ];
//   }

//   List<LiveData> getChartData8() {
//     return <LiveData>[
//       LiveData(0, 41),
//       LiveData(1, 45),
//       LiveData(2, 46),
//       LiveData(3, 47),
//       LiveData(4, 31),
//       LiveData(5, 32),
//       LiveData(6, 34),
//       LiveData(7, 30),
//       LiveData(8, 30),
//       LiveData(9, 50),
//       LiveData(10, 51),
//       LiveData(11, 53),
//       LiveData(12, 56),
//       LiveData(13, 44),
//       LiveData(14, 46),
//       LiveData(15, 92),
//       LiveData(16, 95),
//       LiveData(17, 78),
//       LiveData(18, 60),
//     ];
//   }
// }

// //!Ini buat pemanggilan class Livedatanya
// class LiveData {
//   LiveData(this.time, this.speed);
//   final int time;
//   final num speed;
// }

// class LiveData2 {
//   LiveData2(this.time, this.speed);
//   final int time;
//   final num speed;
// }

// //!Ini buat pemanggilan class Livedatanya
// class LiveData3 {
//   LiveData3(this.time, this.speed);
//   final int time;
//   final num speed;
// }

// class LiveData4 {
//   LiveData4(this.time, this.speed);
//   final int time;
//   final num speed;
// }

// //!Ini buat pemanggilan class Livedatanya
// class LiveData5 {
//   LiveData5(this.time, this.speed);
//   final int time;
//   final num speed;
// }

// class LiveData6 {
//   LiveData6(this.time, this.speed);
//   final int time;
//   final num speed;
// }

// //!Ini buat pemanggilan class Livedatanya
// class LiveData7 {
//   LiveData7(this.time, this.speed);
//   final int time;
//   final num speed;
// }

// class LiveData8 {
//   LiveData8(this.time, this.speed);
//   final int time;
//   final num speed;
// }

// Backup code pleas dont delete it
// Future<MqttServerClient> connect(
//     {required onConnected(),
//     required onDisconnected(),
//     required onSubscribed(String topic),
//     required onUnsubscribed(String? topic)
//     // ,required onSubscribed()
//     }) async {
//   MqttServerClient client =
//       MqttServerClient.withPort('10.10.0.167', 'flutter', 1883);
//   // final String opic = "sensor";
//   // client.port = 9001;

//   client.logging(on: true);
//   client.onConnected = onConnected;
//   client.onDisconnected = onDisconnected;
//   // client.onSubscribed = onSubscribed;
//   client.onUnsubscribed = onUnsubscribed;
//   client.onSubscribed = onSubscribed;
//   // client.onSubscribeFail = onSubscribeFail;
//   // client.pongCallback = pong;

//   final connMessage = MqttConnectMessage()
//       .authenticateAs('', '')
//       // .keepAliveFor(60)
//       .withWillTopic('willtopic')
//       .withWillMessage('Will message')
//       .startClean()
//       .withWillQos(MqttQos.atLeastOnce);
//   client.connectionMessage = connMessage;
//   try {
//     await client.connect();
//   } catch (e) {
//     print('Exception: $e');
//     client.disconnect();
//   }

//   client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
//     // final MqttMessage message = c[0].payload;
//     // print(message);
//     // final payload =
//     //     MqttPublishPayload.bytesToStringAsString(message);

//     // print('Received message:$payload from topic: ${c[0].topic}>');
//   });

//   return client;
// }
