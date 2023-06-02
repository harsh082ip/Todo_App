import 'package:appwrite/models.dart' as appwrite;
import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth.dart';
import 'package:todo_app/sharedPref.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider() {
    readtodos();
  }

  // adding Database and Collection Id
  String databaseId = "6475218aa2fbd1197f94";
  String collectionId = "647521b352462c3d8fce";

  final Databases database = Databases(client);

  List<appwrite.Document> _todos = [];

  // get all todos and store them in _todos
  List<appwrite.Document> get alltodos => _todos;

  void clearTodos() {
    _todos.clear();
    readtodos();
    notifyListeners();
  }

  // isLoading for CircularProgressIndicator
  bool _isLoading = false;

  // check if it is loading
  bool get checkLoading => _isLoading;

  // read all the todos
  // Future readtodos() async {
  //   // _todos.clear();
  //   print('Fetching data');
  //   final email = await UserSavedData.getEmail();

  //   try {
  //     final data = await database.listDocuments(
  //       databaseId: databaseId,
  //       collectionId: collectionId,
  //     );

  //     final filteredDocuments = data.documents.where((document) {
  //       final createdBy = document.data['CreatedBy'];
  //       return createdBy == email;
  //     }).toList();

  //     _todos.addAll(filteredDocuments);
  //   } catch (e) {
  //     print("ahhhhhh");
  //   }
  //   notifyListeners();
  // }

  Future readtodos() async {
    _isLoading = true;
    notifyListeners();
    print('Fetching data');
    final email = await UserSavedData.getEmail();

    try {
      final data = await database.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
      );

      final filteredDocuments = data.documents.where((document) {
        final createdBy = document.data['CreatedBy'];
        return createdBy == email;
      }).toList();

      _todos.clear(); // Clear the existing todos
      _todos.addAll(filteredDocuments); // Add the filtered documents

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      print("Error fetching todos: $e");
    }
  }

  // create a new todo
  Future createTodo(String? title, String? description) async {
    final email = await UserSavedData.getEmail();
    print(email.toString());
    final collection = await database.createDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: ID.unique(),
      data: {
        "Title": title,
        "Description": description,
        "isDone": false,
        "CreatedBy": email
      },
    );
    // readtodos();
    _todos.add(collection);
    notifyListeners();
  }

  // make changes in the todo done or undone
  Future markCompleted(String id, bool isDone) async {
    final email = await UserSavedData.getEmail();

    try {
      final document = await database.getDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: id,
      );

      if (document.data['CreatedBy'] == email) {
        await database.updateDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: id,
          data: {
            "isDone": isDone,
          },
        );

        print('Document Modified');

        // Update the corresponding todo in the _todos list
        final index = _todos.indexWhere((todo) => todo.$id == id);
        if (index != -1) {
          _todos[index].data['isDone'] = isDone;
        }

        notifyListeners();
      } else {
        print('Unauthorized access');
      }
    } catch (e) {
      print(e);
    }
  }

  // update a todo
//   Future updateTodo(String title, String desc, String id) async {
//     final data = await database.updateDocument(
//       databaseId: databaseId,
//       collectionId: collectionId,
//       documentId: id,
//       data: {
//         "Title": title,
//         "Description": desc,
//       },
//     );
//     print('Todo Updated');

//     // readtodos();
//     notifyListeners();
//   }
// }

// update a todo
  Future updateTodo(String title, String desc, String id) async {
    await database.updateDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: id,
      data: {
        "Title": title,
        "Description": desc,
      },
    );
    print('Todo Updated');

    // Update the corresponding todo in the _todos list
    final index = _todos.indexWhere((todo) => todo.$id == id);
    if (index != -1) {
      _todos[index].data['Title'] = title;
      _todos[index].data['Description'] = desc;
    }

    notifyListeners();
  }

  // delete a todo
  Future deleteTodo(String id) async {
    final data = await database.deleteDocument(
        databaseId: databaseId, collectionId: collectionId, documentId: id);
    readtodos();
    notifyListeners();
  }

  // get the length of all completed todos
  int getcompletedLength() {
    int count = 0;
    for (var i = 0; i < _todos.length; i++) {
      if (_todos[i].data['isDone']) {
        count++;
      }
    }
    return count;
  }

  // delete all the todos
  Future deleteAllTodos() async {
    for (var i = 0; i < _todos.length; i++) {
      await database.deleteDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: _todos[i].$id);
    }
    readtodos();
    notifyListeners();
  }
}
