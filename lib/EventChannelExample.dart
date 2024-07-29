import 'package:flutter/cupertino.dart';

import 'main.dart';

class SensorData extends StatefulWidget {
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  String _sensorData = 'Waiting for sensor data...';

  @override
  void initState() {
    super.initState();
    MyApp.eventChannel.receiveBroadcastStream().listen(_onDataReceived, onError: _onError);
  }

  void _onDataReceived(dynamic data) {
    setState(() {
      _sensorData = 'Sensor data: $data';
    });
  }

  void _onError(dynamic error) {
    setState(() {
      _sensorData = 'Error: ${error.message}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_sensorData),
    );
  }
}