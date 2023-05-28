import 'justpassme_flutter_platform_interface.dart';

class JustpassmeFlutter {
  Future<Map<dynamic, dynamic>> register(String url, Map<String, String> headers) {
    return JustpassmeFlutterPlatform.instance.register(url, headers);
  }

  Future<Map<dynamic, dynamic>> login(String url, Map<String, String> headers) {
    return JustpassmeFlutterPlatform.instance.login(url, headers);
  }
}
