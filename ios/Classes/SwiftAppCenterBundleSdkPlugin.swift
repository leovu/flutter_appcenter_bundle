import Flutter
import UIKit
import AppCenter

import AppCenterAnalytics
import AppCenterCrashes
import AppCenterDistribute
public class SwiftAppCenterBundleSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "it.sarni.flutter_flutter_appcenter", binaryMessenger: registrar.messenger())
    let instance = SwiftAppCenterBundleSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    debugPrint(call.method)
        switch call.method {
        case "start":
            guard let args:[String: Any] = (call.arguments as? [String: Any]) else {
                result(FlutterError(code: "400", message:  "Bad arguments", details: "iOS could not recognize flutter arguments in method: (start)") )
                return
            }

            let secret = args["secret"] as! String
            let usePrivateTrack = args["usePrivateTrack"] as! Bool
            if (usePrivateTrack) {
                Distribute.updateTrack = .private
            }
            AppCenter.logLevel = .verbose
            AppCenter.start(withAppSecret: secret, services:[
                Analytics.self,
                Crashes.self,
                Distribute.self,
            ])
        case "trackEvent":
            trackEvent(call: call, result: result)
            return
        case "isDistributeEnabled":
            result(Distribute.enabled)
            return
        case "getInstallId":
            result(AppCenter.installId.uuidString)
            return
        case "configureDistribute":
            Distribute.enabled = call.arguments as! Bool
        case "configureDistributeDebug":
            result(nil)
            return
        case "disableAutomaticCheckForUpdate":
            Distribute.disableAutomaticCheckForUpdate()
        case "checkForUpdate":
            Distribute.checkForUpdate()
        case "isCrashesEnabled":
            result(Crashes.enabled)
            return
        case "configureCrashes":
            Crashes.enabled = (call.arguments as! Bool)
        case "isAnalyticsEnabled":
            result(Analytics.enabled)
            return
        case "configureAnalytics":
            Analytics.enabled = (call.arguments as! Bool)
        default:
            result(FlutterMethodNotImplemented);
            return
        }
        
        result(nil);
    
  }
    private func trackEvent(call: FlutterMethodCall, result: FlutterResult) {
           guard let args:[String: Any] = (call.arguments as? [String: Any]) else {
               result(FlutterError(code: "400", message:  "Bad arguments", details: "iOS could not recognize flutter arguments in method: (trackEvent)") )
               return
           }
           
           let name = args["name"] as? String
           let properties = args["properties"] as? [String: String]
           if(name != nil) {
               Analytics.trackEvent(name!, withProperties: properties)
           }
           
           result(nil)
       }

}
