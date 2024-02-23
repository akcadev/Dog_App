import UIKit
import Flutter
import Foundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    setupMethodChannels()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func setupMethodChannels() {
    let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.example.dog_app/os_version", binaryMessenger: flutterViewController.binaryMessenger)

    channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "getOSVersion" {
        result(UIDevice.current.systemVersion)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
