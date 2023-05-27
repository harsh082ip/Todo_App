import 'package:flutter/material.dart';
import 'package:todo_app/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Todo\'s'),
          actions: [
            IconButton(
              onPressed: () {
                logoutUser().then((value) {
                  if (value) {
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed Logging out'),
                      ),
                    );
                  }
                });
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(child: Text('Hello User')),
      ),
    );
  }
}
