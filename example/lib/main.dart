import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'AuthGate.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'justpass-me-sdk-example',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseUIAuth.configureProviders([
      EmailLinkAuthProvider(
        actionCodeSettings: ActionCodeSettings(
          url: 'https://justpassmeflutterexample.page.link/email-link-login',
          handleCodeInApp: true,
          androidMinimumVersion: '1',
          androidPackageName: 'tech.amwal.auth.justpassme_flutter_example',
          iOSBundleId: 'tech.amwal.auth.justpassmeFlutterExample',
        ),
      ),
    ]);
  }
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

  //Splash screen Widget
  Widget splashScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'JustPassMe',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget root = MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthGate(),
    );
    return root;
  }
}
