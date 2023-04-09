
import 'justpassme_flutter_platform_interface.dart';

class JustpassmeFlutter {

  Future<String?> getPlatformVersion() {
    return JustpassmeFlutterPlatform.instance.getPlatformVersion();
  }

  Future<String?> register(String sessionId) {
    return JustpassmeFlutterPlatform.instance.register(sessionId);
  }

  Future<String?> login(String sessionId) {
    return JustpassmeFlutterPlatform.instance.login(sessionId);
  }
}
