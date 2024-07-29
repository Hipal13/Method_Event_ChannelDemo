import UIKit
import Flutter
// import CoreMotion

@UIApplicationMain

method channel
@objc class AppDelegate: FlutterAppDelegate {
  private let CHANNEL = "com.example.method_event_channel"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let osVersionChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

    osVersionChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "getOSVersion" {
        let osVersion = UIDevice.current.systemVersion
        result(osVersion)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

//
//  @objc class AppDelegate: FlutterAppDelegate {
//    private let CHANNEL = "com.example.method_event_channel"
//    private var motionManager: CMMotionManager?
//
//    override func application(
//      _ application: UIApplication,
//      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//    ) -> Bool {
//      let controller = window?.rootViewController as! FlutterViewController
//      let sensorDataChannel = FlutterEventChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
//
//      sensorDataChannel.setStreamHandler(SensorDataStreamHandler())
//
//      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//    }
//  }
//
//  class SensorDataStreamHandler: NSObject, FlutterStreamHandler {
//    private var eventSink: FlutterEventSink?
//    private let motionManager = CMMotionManager()
//
//    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
//      self.eventSink = events
//      startSendingSensorData()
//      return nil
//    }
//
//    func onCancel(withArguments arguments: Any?) -> FlutterError? {
//      stopSendingSensorData()
//      eventSink = nil
//      return nil
//    }
//
//    private func startSendingSensorData() {
//      if motionManager.isAccelerometerAvailable {
//        motionManager.accelerometerUpdateInterval = 0.1
//        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] (data, error) in
//          guard let self = self, let eventSink = self.eventSink else { return }
//          if let error = error {
//            eventSink(FlutterError(code: "SENSOR_ERROR", message: error.localizedDescription, details: nil))
//            return
//          }
//          if let data = data {
//            let sensorData = [
//              "x": data.acceleration.x,
//              "y": data.acceleration.y,
//              "z": data.acceleration.z
//            ]
//            eventSink(sensorData)
//          }
//        }
//      } else {
//        eventSink?(FlutterError(code: "UNAVAILABLE", message: "Accelerometer not available", details: nil))
//      }
//    }
//
//    private func stopSendingSensorData() {
//      motionManager.stopAccelerometerUpdates()
//    }
//  }