import Flutter
import UIKit
import JustPassMeFramework

@available(iOS 16.0, *)
public class JustpassmeFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "justpassme_flutter", binaryMessenger: registrar.messenger())
        let instance = JustpassmeFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handleJustPassMeClientError(_ error: Error, result: @escaping FlutterResult) {
        let customError = error as? JustPassMeClient.JustPassMeClientError
        switch customError {
        case .badURL:
            result(FlutterError(code: "BAD_URL", message: "Bad URL", details: nil))
        case .badResponse:
            result(FlutterError(code: "BAD_RESPONSE", message: "Bad Response", details: nil))
        case .noPublicKey:
            result(FlutterError(code: "NO_PUBLIC_KEY", message: "No Public Key", details: nil))
        case .runtimeError(let errorMessage):
            result(FlutterError(code: "RUNTIME_ERROR", message: errorMessage, details: nil))
        case .none:
            let nsError = error as NSError
            result(FlutterError(code: "UNKNOWN_ERROR", message: nsError.localizedDescription, details: nil))
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let vc = UIApplication.shared.delegate?.window??.rootViewController  as? FlutterViewController {
            switch call.method {
            case "register":
                Task{
                    let argumentsDictionary = call.arguments as? Dictionary<String, Any>
                    do {
                        let JustPassMeClient = await JustPassMeClient(presentationAnchor:(vc.view.window)!);
                        let response = try await JustPassMeClient.register( registrationURL: argumentsDictionary?["url"] as! String,
                                                                            extraClientHeaders: argumentsDictionary?["headers"] as! [String: String]);
                        result(response)
                        
                    } catch {
                        handleJustPassMeClientError(error, result: result)
                    }
                }
                
            case "login" :
                Task{
                    let argumentsDictionary = call.arguments as? Dictionary<String, Any>
                    do {
                        let JustPassMeClient = await JustPassMeClient(presentationAnchor:(vc.view.window)!);
                        let response = try await JustPassMeClient.authenticate(authenticationURL: argumentsDictionary?["url"] as! String,
                                                                            extraClientHeaders: argumentsDictionary?["headers"] as! [String: String]);
                        result(response)
                        
                    } catch {
                        handleJustPassMeClientError(error, result: result)
                    }
                }
            default :
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
