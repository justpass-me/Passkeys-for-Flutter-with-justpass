import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'justpassme_flutter_method_channel.dart';

abstract class JustPassMeFlutterPlatform extends PlatformInterface {
  /// Constructs a JustpassmeFlutterPlatform.
  JustPassMeFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static JustPassMeFlutterPlatform _instance = MethodChannelJustPassMe();

  /// The default instance of [JustPassMeFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelJustPassMe].
  static JustPassMeFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [JustPassMeFlutterPlatform] when
  /// they register themselves.
  static set instance(JustPassMeFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<dynamic, dynamic>> register(
      String url, Map<String, String> headers) {
    throw UnimplementedError('register() has not been implemented.');
  }

  Future<Map<dynamic, dynamic>> login(String url, Map<String, String> headers) {
    throw UnimplementedError('login() has not been implemented.');
  }
}
