import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInHttp {
  final baseUrl = 'https://thebank.demo.1pass.tech/';
  // an immutable variable that holds the sessionId cache for later use in the app
  String? sessionId = '';

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
      final session =  response.headers['set-cookie']!.split(';')[0].split('=')[1];
      sessionId = session;
      return session;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<String> prepareSecureLogin() async {
    final url = Uri.parse('$baseUrl/secure_login/start_sign_in');

    final response = await http
        .get(url, headers: {"Cookie": 'sessionid=$sessionId'});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load sign in data');
    }
  }
}
