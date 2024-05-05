import UIKit
import SwiftUI
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

      
      let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
      let navigationController = UINavigationController(rootViewController: flutterViewController)
         navigationController.isNavigationBarHidden = true // Optional: Hide the navigation bar.
      
      self.window = UIWindow(frame: UIScreen.main.bounds)
      self.window?.rootViewController = navigationController
      self.window?.makeKeyAndVisible()

      setupMethodChannel(flutterViewController: flutterViewController)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    

    
    private func setupMethodChannel(flutterViewController: FlutterViewController) {
        let channel = FlutterMethodChannel(name: "my_flutter_plugin", binaryMessenger: flutterViewController.binaryMessenger)
        channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
          if call.method == "navigateToNativeView" {
            guard let args = call.arguments as? [String: Any], let navigationController = self.window?.rootViewController as? UINavigationController else {
                   result(FlutterError(code: "ERROR", message: "Arguments not received", details: nil))
                   return
            }
              
            let arg1 = args["arg1"] as? String ?? ""
            let arg2 = args["arg2"] as? Int ?? 0
            DispatchQueue.main.async {
              let swiftUIView = UIHostingController(rootView: SwiftUIView(arg1: arg1, arg2: arg2))
              navigationController.pushViewController(swiftUIView, animated: true)
            }
            result("Success")
          } else {
            result(FlutterMethodNotImplemented)
          }
        }
      }
}
