import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class MethodChannelScreen extends StatefulWidget {
  @override
  _MethodChannelScreenState createState() => _MethodChannelScreenState();
}

class _MethodChannelScreenState extends State<MethodChannelScreen> {
  String _batteryLevel = 'What is my battery level?';
  String _osVersion = 'Unknown OS version';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await MyApp.platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result %.';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  Future<void> _getOSVersion() async {
    String osVersion;
    try {
      final String result = await MyApp.platform.invokeMethod('getOSVersion');
      osVersion = 'OS Version: $result';
    } on PlatformException catch (e) {
      osVersion = "Failed to get OS version: '${e.message}'.";
    }

    setState(() {
      _osVersion = osVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_batteryLevel,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 20),),
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: _getBatteryLevel,
          child: Text('Get Battery Level'),
        ),
        SizedBox(height: 30,),
        Text(_osVersion,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 20)),
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: _getOSVersion,
          child: Text('Get OS Version'),
        ),
      ],
    );
  }
}
