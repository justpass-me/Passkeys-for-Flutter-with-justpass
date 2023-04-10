import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginHttp {
  final baseUrl = 'https://thebank.demo.1pass.tech/';
  final storage = const FlutterSecureStorage();

  // an immutable variable that holds the sessionId cache for later use in the app

  void cacheSessionId(String sessionId) async {
    // Create storage
    await storage.write(key: 'sessionId', value: sessionId);
  }

  Future<String> getSessionId() async {
    // Read value
    final sessionId = await storage.read(key: 'sessionId');
    return sessionId!;
  }

  Future<String> loginWithUsernameAndPassword(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final session =
          response.headers['set-cookie']!.split(';')[0].split('=')[1];
      cacheSessionId(session);
      return session;
    } else {
      throw Exception('Failed to loginWithUsernameAndPassword');
    }
  }

  Future<String> prepareSecureLogin() async {
    final url = Uri.parse('$baseUrl/secure_login/start_sign_in');
    final sessionId = await getSessionId();
    final response =
        await http.get(url, headers: {"Cookie": 'sessionid=$sessionId'});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to start_sign_in data');
    }
  }

  Future<String> checkPassword(String password) async {
    final url =
        Uri.parse('$baseUrl/secure_login/check_password?password=$password');
    final sessionId = await getSessionId();
    final response =
        await http.get(url, headers: {"Cookie": 'sessionid=$sessionId'});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load checkPassword${response.body}');
    }
  }
}
