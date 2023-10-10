import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:justpassme_flutter_example/pages/home.dart';
import 'package:justpassme_flutter/justpassme_flutter.dart';
import 'package:justpassme_flutter_example/config.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final justPassMeClient = JustPassMe();
  bool isLoading = false;
  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pop(context);
              }),
            ],
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to JustPass.me, please sign in!')
                    : const Text('Welcome to JustPass.me, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                    onPressed: isButtonDisabled
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                              isButtonDisabled = true;
                            });
                            try {
                              final result =
                                  await justPassMeClient.login(loginUrl, {});
                              String? token = result['token'] as String?;
                              if (token != null) {
                                await FirebaseAuth.instance
                                    .signInWithCustomToken(token);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ));
                              }
                            } catch (e) {
                              print(e);
                            } finally {
                              setState(() {
                                isLoading = false;
                                isButtonDisabled = false;
                              });
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Sign in with JustPass.me')),
              );
            },
          );
        } else {
          return HomeScreen();
        }
      },
    );
  }
}
