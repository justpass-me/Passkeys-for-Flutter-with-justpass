import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'justpassme_flutter_platform_interface.dart';

/// An implementation of [MethodChannelJustPassMe] that uses method channels.
class MethodChannelJustPassMe extends JustPassMeFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('justpassme_flutter');

  @override
  Future<Map<dynamic, dynamic>> register(
    String url,
    Map<String, String> headers
  ) async {
    final response = await methodChannel.invokeMethod<Map<dynamic, dynamic>>('register', {
      "url": url,
      "headers": headers
    });
    return response ?? {};
  }

  @override
  Future<Map<dynamic, dynamic>> login(
      String url,
      Map<String, String> headers
  ) async {
    final response = await methodChannel.invokeMethod<Map<dynamic, dynamic>>('login', {
      "url": url,
      "headers": headers
    });
    return response ?? {};
  }
}
