import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controllers/todo_provider.dart';
import 'package:todo_app/screens/checkUserAuthentication.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/signup.dart';
import 'screens/login.dart';

// Client client = Client();
// For self signed certificates, only use for development

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => TodoProvider()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: LoginPage(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
                color: Colors
                    .black), // Set the desired color for the app drawer icon
          ),
        ),
        routes: {
          '/': (context) => CheckUserAuth(),
          '/home': (context) => HomePage(),
          '/login': (context) => LoginPage(),
          '/SignUp': (context) => SignUp(),
        },
      ),
    );
  }
}
