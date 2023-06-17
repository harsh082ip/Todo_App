import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controllers/todo_provider.dart';

import 'package:todo_app/screens/checkUserAuthentication.dart';
import 'package:todo_app/screens/editTodos.dart';

import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/newTodo.dart';
import 'package:todo_app/screens/signup.dart';
import 'package:todo_app/sharedPref.dart';

import 'screens/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UserSavedData.init().then((_) {
    runApp(const TodoApp());
  });
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
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        routes: {
          '/': (context) => const CheckUserAuth(),
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/SignUp': (context) => const SignUp(),
          '/newTodo': (context) => const NewTodo(),
        },
        // onGenerateRoute: (settings) {
        //   if (settings.name == '/edit') {
        //     // Extract the arguments
        //     final args = settings.arguments;

        //     // Return the appropriate MaterialPageRoute for the '/edit' route.
        //     return MaterialPageRoute(
        //       builder: (context) {
        //         // Build and return the screen/widget for the '/edit' route, passing the arguments.
        //         return EditTodos(
        //             /* Pass the arguments to the EditTodos widget constructor */);
        //       },
        //     );
        //   }
        //   // Handle other routes here if needed.
        //   return null;
        // },
      ),
    );
  }
}
