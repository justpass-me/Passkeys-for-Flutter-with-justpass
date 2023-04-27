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
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let vc = UIApplication.shared.delegate?.window??.rootViewController  as? FlutterViewController {
            switch call.method {
            case "register":
                Task{
                    let argumentsDictionary = call.arguments as? Dictionary<String, Any>
                    do {
                        let amwalAuthClient = await JustPassMeClient(clientURL: argumentsDictionary?["clientUrl"] as! String,
                                                                     authServiceURL:argumentsDictionary?["serviceUrl"] as! String,
                                                                     token :argumentsDictionary?["token"] as! String,
                                                                     presentationAnchor:(vc.view.window)!);
                        let response = try await amwalAuthClient.register();
                        result(response)
                        
                    } catch {
                        result("AmwalAuth" + error.localizedDescription)
                    }
                }
                
            case "login" :
                Task{
                    let argumentsDictionary = call.arguments as? Dictionary<String, Any>
                    do {
                        let amwalAuthClient = await JustPassMeClient(clientURL: argumentsDictionary?["clientUrl"] as! String,
                                                                     authServiceURL:argumentsDictionary?["serviceUrl"] as! String,
                                                                     token :argumentsDictionary?["token"] as! String,
                                                                     presentationAnchor:(vc.view.window)!);
                        let response = try await amwalAuthClient.authenticate(autoFill: true);
                        result(response)
                        
                    } catch {
                        result("AmwalAuth" + error.localizedDescription)
                    }
                }
            default :
                result("iOS " + UIDevice.current.systemVersion)
                
            }
        }
    }
}
