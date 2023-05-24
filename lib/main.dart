import 'package:flutter/material.dart';
import 'package:todo_app/screens/signup.dart';
import 'screens/login.dart';

// Client client = Client();
// For self signed certificates, only use for development

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
              color: Colors
                  .black), // Set the desired color for the app drawer icon
        ),
      ),
    );
  }
}
