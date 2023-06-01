import 'package:flutter/material.dart';
import 'package:justpassme_flutter/justpassme_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justpassme_flutter_example/config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final justPassMeClient = JustPassMe();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0), // apply padding to all sides
            child: 
              Text('Welcome ${user?.email}',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))),
          ElevatedButton(
            onPressed: () async {
              try{
                final userToken = await user?.getIdToken();
                await justPassMeClient.register(registerUrl,
                  {"Authorization": "Bearer $userToken"});
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('${e}'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
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
