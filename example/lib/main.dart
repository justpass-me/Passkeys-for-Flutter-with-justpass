import 'package:flutter/material.dart';
import 'package:justpassme_flutter_example/pages/home.dart';
import 'package:justpassme_flutter_example/pages/login.dart';
import 'package:justpassme_flutter_example/pages/sign_in_http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      // The slash means the home page
      '/': (context) => const LoginPage(),
      // The second page
      '/home': (context) => const Home(),
    });
  }
}
