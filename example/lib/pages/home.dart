import 'package:flutter/material.dart';
import 'package:justpassme_flutter/justpassme_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justpassme_flutter_example/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final justPassMeClient = JustPassMe();
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to JustPass.me ! ${user?.email}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isButtonDisabled
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                        isButtonDisabled = true;
                      });
                      try {
                        final userToken = await user?.getIdToken();
                        await justPassMeClient.register(registerUrl,
                            {"Authorization": "Bearer $userToken"});
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('$e'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } finally {
                        setState(() {
                          isLoading = false;
                          isButtonDisabled = false;
                        });
                      }
                    },
              child: isLoading
                  ? CircularProgressIndicator()
                  : const Text('Create a Passkey'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                minimumSize: const Size(double.infinity, 35.0),
              ),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                minimumSize: const Size(double.infinity, 35.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
