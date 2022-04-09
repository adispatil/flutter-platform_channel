import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let flutterChannel = FlutterMethodChannel(name: "com.platform_channel_demo",
                                                  binaryMessenger: controller.binaryMessenger)
        
        flutterChannel.setMethodCallHandler({
            [weak self](call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread.
//            guard call.method == "getBatteryLevel" else {
//                result(FlutterMethodNotImplemented)
//                return
//            }
//            self?.receiveBatteryLevel(result: result)
            
            if(call.method == "getBatteryLevel"){
                self?.receiveBatteryLevel(result: result)
            } else if(call.method == "getDeviceName") {
                self?.getDeviceName(result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(FlutterError(code: "UNAVAILABLEEEEEE",
                                message: "Battery info unavailable",
                                details: nil))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
    
    private func getDeviceName(result: FlutterResult) {
        let device = UIDevice.current
        if device.name.isEmpty == UIDevice.current.name.isEmpty {
            result(FlutterError(code: "UNAVAILABLEEEEEE",
                                message: "Unable to get device name",
                                details: nil))
        } else {
            result(String(device.name + device.model))
        }
    }
    
}
