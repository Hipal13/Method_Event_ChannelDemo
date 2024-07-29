import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'MethodChennelExample.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const EventChannel eventChannel = EventChannel('com.example.method_event_channel');
  static const platform = MethodChannel('com.example.method_event_channel');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text('Method Chennel'),
        ),
        body: Center(
          child: MethodChannelScreen(),
        ),
      ),
    );
  }
}

