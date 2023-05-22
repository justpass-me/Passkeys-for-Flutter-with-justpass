import 'package:flutter/material.dart';
import 'package:justpassme_flutter/justpassme_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justpassme_flutter_example/config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final justPassMeClient = JustpassmeFlutter();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final userToken = await user?.getIdToken();
              await justPassMeClient.register(registerUrl,
                  {"Authorization": "Bearer $userToken"});
            },
            child: Text('Register'),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, '/');
            },
            child: Text('Logout'),
          ),
        ],
      )),
    );
  }
}
