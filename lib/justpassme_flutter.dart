import 'justpassme_flutter_platform_interface.dart';

class JustPassMe {
  Future<Map<dynamic, dynamic>> register(String url, Map<String, String> headers) {
    return JustPassMeFlutterPlatform.instance.register(url, headers);
  }

  Future<Map<dynamic, dynamic>> login(String url, Map<String, String> headers) {
    return JustPassMeFlutterPlatform.instance.login(url, headers);
  }
}
