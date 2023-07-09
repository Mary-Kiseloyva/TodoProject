import 'package:flutter/material.dart';
import 'package:poni/model/todo_model.dart';
import 'package:poni/model/todo_storage.dart';
import 'package:poni/todo_list_page/note_page.dart';
import 'package:intl/intl.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final DateFormat formatter = DateFormat('MMM dd');
  Iterable<TodoModel> _todos = TodoStorage.getAll();
  bool visibility = true;

  void refreshToDos() {
    if (visibility) {
      _todos = TodoStorage.getAll();
    } else {
      _todos = TodoStorage.getNotDone();
    }
  }

  @override
  Widget build(BuildContext context) {
    int count = TodoStorage.getAll().where((todo) => todo.done == true).length;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: true,
        title: Text(
          'Мои дела',
          style: themeData.textTheme.headlineLarge,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Container(
          height: 500,
          width: 500,
          margin: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 5,
          ),
          child: Column(children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Выполнено - $count"),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          visibility = !visibility;
                          refreshToDos();
                        });
                      },
                      icon: Icon(
                        visibility ? Icons.visibility : Icons.visibility_off,
                        color: Colors.orange,
                      ))
                ],
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: ListView.builder(
                  itemCount: _todos.length,
                  itemBuilder: (context, index) {
                    final todo = _todos.elementAt(index);

                    TextDecoration textDecoration = todo.done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none;
                    return Dismissible(
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            TodoModel model = todo.copyWith(done: true);
                            TodoStorage.put(model.id!, model);
                            setState(() {
                              refreshToDos();
                            });
                            return false;
                          }
                          return true;
                        },
                        background: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          color: Colors.green,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          padding: const EdgeInsets.only(right: 10.0),
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        key: ValueKey<int>(todo.id!),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NotePage()),
                            );
                          },
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            value: todo.done,
                            onChanged: (_) {},
                            title: Text(
                              todo.text,
                              style: TextStyle(decoration: textDecoration),
                            ),
                            subtitle: todo.deadLine == null
                                ? null
                                : Text(formatter.format(todo.deadLine!)),
                          ),
                        ),
                        onDismissed: (DismissDirection direction) {
                          TodoStorage.remove(todo.id!);
                          setState(() {
                            refreshToDos();
                          });
                        });
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NotePage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
