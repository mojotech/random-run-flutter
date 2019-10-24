import UIKit
import Flutter
import GoogleMaps
import Foundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let API_KEY: String = ProcessInfo.processInfo.environment["GOOGLE_MAPS_API_KEY"] ??  "Not Found"
    GMSServices.provideAPIKey(API_KEY)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
