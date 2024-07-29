package com.example.method_event_channel


//Method Chennel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import android.content.Context
import android.os.BatteryManager
import android.os.Build


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.method_event_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            }
            if (call.method == "getOSVersion") {
                val osVersion = android.os.Build.VERSION.RELEASE
                result.success(osVersion)
            }else {
                result.notImplemented()
            }
        }
    }



    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            -1
        }
    }

}


//Event Method
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.EventChannel
//import android.hardware.Sensor
//import android.hardware.SensorEvent
//import android.hardware.SensorEventListener
//import android.hardware.SensorManager
//
//class MainActivity: FlutterActivity(), SensorEventListener {
//    private val SENSOR_CHANNEL = "com.example.method_event_channel"
//    private lateinit var sensorManager: SensorManager
//    private var sensor: Sensor? = null
//    private var eventSink: EventChannel.EventSink? = null
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        EventChannel(flutterEngine.dartExecutor.binaryMessenger, SENSOR_CHANNEL).setStreamHandler(
//            object : EventChannel.StreamHandler {
//                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
//                    eventSink = events
//                    sensorManager = getSystemService(SENSOR_SERVICE) as SensorManager
//                    sensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
//                    sensorManager.registerListener(this@MainActivity, sensor, SensorManager.SENSOR_DELAY_NORMAL)
//                }
//
//                override fun onCancel(arguments: Any?) {
//                    sensorManager.unregisterListener(this@MainActivity)
//                    eventSink = null
//                }
//            }
//        )
//    }
//
//    override fun onSensorChanged(event: SensorEvent?) {
//        event?.let {
//            eventSink?.success(it.values.joinToString(", "))
//        }
//    }
//
//    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
//}
