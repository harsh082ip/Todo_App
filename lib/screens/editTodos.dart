import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controllers/todo_provider.dart';

class EditTodos extends StatefulWidget {
  final String todoId; // Add todoId parameter
  final String title; // Add title parameter
  final String description; // Add description parameter

  const EditTodos({
    required this.todoId,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  State<EditTodos> createState() => _EditTodosState();
}

class _EditTodosState extends State<EditTodos> {
  late TextEditingController titlecontroller;
  late TextEditingController descriptioncontroller;

  @override
  void initState() {
    super.initState();
    titlecontroller = TextEditingController(text: widget.title);
    descriptioncontroller = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    descriptioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Todo'),
        backgroundColor: Color.fromARGB(255, 77, 182, 172),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 60.0,
              child: TextFormField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120.0,
              child: TextFormField(
                controller: descriptioncontroller,
                style: TextStyle(color: Colors.purple),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.only(bottom: 200.0),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text('Description'),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              try {
                provider.updateTodo(titlecontroller.text,
                    descriptioncontroller.text, widget.todoId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Todo Updated'),
                  ),
                );
                Navigator.pop(context);
              } catch (e) {
                print(e);
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
