import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth.dart';
import 'package:todo_app/controllers/todo_provider.dart';

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
        body: Consumer(
          builder: (context, TodoProvider provider, child) {
            return ListView.builder(
              itemCount: provider.alltodos.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(provider.alltodos[index].data.toString()));
              },
            );
          },
        ),
      ),
    );
  }
}
