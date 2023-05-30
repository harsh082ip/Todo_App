import 'package:appwrite/models.dart' as appwrite;
import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth.dart';

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

  // read all the todos
  Future readtodos() async {
    try {
      final data = await database.listDocuments(
          databaseId: databaseId, collectionId: collectionId);
      _todos = data.documents;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // create a new todo
  Future createTodo(String? title, String? description) async {
    final collection = await database.createDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: ID.unique(),
      data: {
        "Title": title,
        "Description": description,
        "isDone": false,
        "CreatedBy": "gamer@gmail.com"
      },
    );
    readtodos();
    notifyListeners();
  }

  // make changes in the todo done or undone
  Future markCompleted(String id, bool isDone) async {
    final data = await database.updateDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: id,
      data: {
        "isDone": isDone,
      },
    );
    print('Document Modified');

    readtodos();
    notifyListeners();
  }
}
