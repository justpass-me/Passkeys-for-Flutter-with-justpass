import 'justpassme_flutter_platform_interface.dart';

class JustpassmeFlutter {
  Future<String?> getPlatformVersion() {
    return JustpassmeFlutterPlatform.instance.getPlatformVersion();
  }

  Future<String?> register(
    String clientUrl,
    String serviceUrl,
    String token,
  ) {
    return JustpassmeFlutterPlatform.instance
        .register(clientUrl, serviceUrl, token);
  }

  Future<String?> login(
    String clientUrl,
    String serviceUrl,
    String token,
  ) {
    return JustpassmeFlutterPlatform.instance
        .login(clientUrl, serviceUrl, token);
  }
}
