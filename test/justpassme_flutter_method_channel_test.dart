import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:justpassme_flutter/justpassme_flutter_method_channel.dart';

void main() {
  MethodChannelJustpassmeFlutter platform = MethodChannelJustpassmeFlutter();
  const MethodChannel channel = MethodChannel('justpassme_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
