import 'package:flutter/material.dart';
import 'package:justpassme_flutter/justpassme_flutter.dart';
import 'package:justpassme_flutter_example/pages/sign_in_http.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final justPassMeClient = JustpassmeFlutter();
    final loginHttp = LoginHttp();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await loginHttp
                  .checkPassword("123456");
              final session = await loginHttp.getSessionId();
              await justPassMeClient.register(session);
            },
            child: Text('Register'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text('Logout'),
          ),
        ],
      )),
    );
  }
}
