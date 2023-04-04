
import 'justpassme_flutter_platform_interface.dart';

class JustpassmeFlutter {
  Future<String?> getPlatformVersion() {
    return JustpassmeFlutterPlatform.instance.getPlatformVersion();
  }

  Future<String?> register() {
    return JustpassmeFlutterPlatform.instance.register();
  }

  Future<String?> login() {
    return JustpassmeFlutterPlatform.instance.login();
  }
}
