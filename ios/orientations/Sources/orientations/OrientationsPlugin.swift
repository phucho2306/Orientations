import Flutter
import UIKit

public class OrientationsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "orientations", binaryMessenger: registrar.messenger())
        let instance = OrientationsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    public static var allowedOrientations: [String] = [
        "portraitUp",
        "portraitDown",
        "landscapeLeft",
        "landscapeRight"
    ]
    public static func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        var mask: UIInterfaceOrientationMask = []
        for o in allowedOrientations {
            switch o {
            case "portraitUp":
                mask.insert(.portrait)
            case "portraitDown":
                mask.insert(.portraitUpsideDown)
            case "landscapeLeft":
                mask.insert(.landscapeLeft)
            case "landscapeRight":
                mask.insert(.landscapeRight)
            default:
                break
            }
        }
        return mask
    }
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setOrientations":
            guard let args = call.arguments as? [String: Any],
                  let orientations = args["orientations"] as? [String] else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing orientations", details: nil))
                return
            }
            OrientationsPlugin.allowedOrientations = orientations
            UIViewController.attemptRotationToDeviceOrientation()
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
