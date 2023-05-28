import 'package:flutter_test/flutter_test.dart';
import 'package:justpassme_flutter/justpassme_flutter.dart';
import 'package:justpassme_flutter/justpassme_flutter_platform_interface.dart';
import 'package:justpassme_flutter/justpassme_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockJustpassmeFlutterPlatform
    with MockPlatformInterfaceMixin
    implements JustpassmeFlutterPlatform {


  @override
  Future<Map<dynamic, dynamic>> login(String url, Map<String, String> headers) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Map<dynamic, dynamic>> register(String url, Map<String, String> headers) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

void main() {
  final JustpassmeFlutterPlatform initialPlatform = JustpassmeFlutterPlatform.instance;

  test('$MethodChannelJustpassmeFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelJustpassmeFlutter>());
  });
}
