import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controllers/todo_provider.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TodoProvider provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Todo'),
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
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 25.0)),
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
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: EdgeInsets.only(bottom: 200.0),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text('Description'),
                  ),
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 25),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              try {
                provider.createTodo(
                    titlecontroller.text, descriptioncontroller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Todo Created'),
                  ),
                );
                Navigator.pop(context);
              } catch (e) {
                print(e);
              }
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
}
