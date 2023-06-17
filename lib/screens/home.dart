import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth.dart';
import 'package:todo_app/controllers/todo_provider.dart';
import 'package:todo_app/screens/editTodos.dart';
import 'package:todo_app/sharedPref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your Todo\'s'),
          backgroundColor: const Color.fromARGB(255, 77, 182, 172),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('Welcome'),
                accountEmail: Text("${UserSavedData.getEmail()}"),
              ),
              ListTile(
                onTap: () {
                  todoProvider.deleteAllTodos().then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All Todos Deleted'),
                        ),
                      );
                    },
                  );
                },
                title: const Text('Delete All Todos'),
                leading: const Icon(Icons.delete_forever),
              ),
              ListTile(
                onTap: () {
                  const Center(child: CircularProgressIndicator());
                  logoutUser().then(
                    (value) => Navigator.pushReplacementNamed(context, '/'),
                  );
                },
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
              )
            ],
          ),
        ),
        body: _selectedIndex == 0 ? showOnGoingTodos() : showCompletedTodos(),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (value) => setState(
                  () {
                    _selectedIndex = value;
                  },
                ),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Todo List'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done), label: 'Completed'),
            ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 77, 182, 172),
          onPressed: () {
            Navigator.pushNamed(context, '/newTodo');
          },
          child: Image.asset('assets/images/create.png'),
        ),
      ),
    );
  }

  Widget showOnGoingTodos() {
    return Consumer(
      builder: (context, TodoProvider provider, child) {
        return provider.checkLoading
            ? const CircularProgressIndicator()
            : provider.alltodos.length - provider.getcompletedLength() == 0
                ? const Center(
                    child: Text('No New Todos'),
                  )
                : ListView.builder(
                    itemCount: provider.alltodos.length,
                    itemBuilder: (context, index) {
                      return provider.alltodos[index].data['isDone']
                          ? const SizedBox()
                          : ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTodos(
                                      todoId: provider.alltodos[index].$id,
                                      title: provider
                                          .alltodos[index].data['Title'],
                                      description: provider
                                          .alltodos[index].data['Description'],
                                    ),
                                  ),
                                );
                              },
                              title: Text(
                                provider.alltodos[index].data['Title'],
                              ),
                              subtitle: Text(
                                  provider.alltodos[index].data['Description']),
                              leading: Checkbox(
                                value:
                                    provider.alltodos[index].data['isDone'] ??
                                        false,
                                onChanged: (value) {
                                  provider.markCompleted(
                                      provider.alltodos[index].$id,
                                      !provider.alltodos[index].data['isDone']);
                                },
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    provider.deleteTodo(
                                        provider.alltodos[index].$id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Todo deleted'),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red,
                                  )),
                            );
                    },
                  );
      },
    );
  }

  Widget showCompletedTodos() {
    return Consumer(
      builder: (context, TodoProvider provider, child) {
        return provider.checkLoading
            ? const CircularProgressIndicator()
            : provider.getcompletedLength() == 0
                ? const Center(
                    child: Text('No Completed Todos'),
                  )
                : ListView.builder(
                    itemCount: provider.alltodos.length,
                    itemBuilder: (context, index) {
                      return provider.alltodos[index].data['isDone'] == false
                          ? const SizedBox()
                          : ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTodos(
                                      todoId: provider.alltodos[index].$id,
                                      title: provider
                                          .alltodos[index].data['Title'],
                                      description: provider
                                          .alltodos[index].data['Description'],
                                    ),
                                  ),
                                );
                              },
                              title: Text(
                                provider.alltodos[index].data['Title'],
                              ),
                              subtitle: Text(
                                  provider.alltodos[index].data['Description']),
                              leading: Checkbox(
                                value:
                                    provider.alltodos[index].data['isDone'] ??
                                        false,
                                onChanged: (value) {
                                  provider.markCompleted(
                                      provider.alltodos[index].$id,
                                      !provider.alltodos[index].data['isDone']);
                                },
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    provider.deleteTodo(
                                        provider.alltodos[index].$id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Todo deleted'),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete_rounded)),
                            );
                    },
                  );
      },
    );
  }
}
