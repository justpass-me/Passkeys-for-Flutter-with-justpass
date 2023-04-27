import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'justpassme_flutter_platform_interface.dart';

/// An implementation of [JustpassmeFlutterPlatform] that uses method channels.
class MethodChannelJustpassmeFlutter extends JustpassmeFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('justpassme_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> register(
    String clientUrl,
    String serviceUrl,
    String token,
  ) async {
    final response = await methodChannel.invokeMethod<String>('register', {
      "clientUrl": clientUrl,
      "serviceUrl": serviceUrl,
      "token": token,
    });
    return response;
  }

  @override
  Future<String?> login(
    String clientUrl,
    String serviceUrl,
    String token,
  ) async {
    final response = await methodChannel.invokeMethod<String>('login', {
      "clientUrl": clientUrl,
      "serviceUrl": serviceUrl,
      "token": token,
    });
    return response;
  }
}
