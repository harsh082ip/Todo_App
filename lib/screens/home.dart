import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth.dart';
import 'package:todo_app/controllers/todo_provider.dart';
import 'package:todo_app/screens/newTodo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Todo\'s'),
          backgroundColor: Color.fromARGB(255, 77, 182, 172),
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
                  title: Text(
                    provider.alltodos[index].data['Title'],
                  ),
                  subtitle: Text(provider.alltodos[index].data['Description']),
                  leading: Checkbox(
                    value: provider.alltodos[index].data['isDone'] ?? false,
                    onChanged: (value) {
                      provider.markCompleted(provider.alltodos[index].$id,
                          !provider.alltodos[index].data['isDone']);
                    },
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 77, 182, 172),
          onPressed: () {
            Navigator.pushNamed(context, '/newTodo');
          },
          child: Image.asset('assets/images/create.png'),
        ),
      ),
    );
  }
}
