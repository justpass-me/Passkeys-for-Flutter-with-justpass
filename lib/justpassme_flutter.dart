import 'justpassme_flutter_platform_interface.dart';

class JustpassmeFlutter {
  Future<String?> register(String url, Map<String, String> headers) {
    return JustpassmeFlutterPlatform.instance.register(url, headers);
  }

  Future<String?> login(String url, Map<String, String> headers) {
    return JustpassmeFlutterPlatform.instance.login(url, headers);
  }
}
