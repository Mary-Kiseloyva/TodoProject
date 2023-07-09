import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poni/model/todo_model.dart';
import 'package:poni/model/todo_storage.dart';
import 'package:poni/todo_list_page/todo_list_page.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  static const routeName = '/note_page';

  @override
  State<NotePage> createState() => _NotePage();
}

class _NotePage extends State<NotePage> {
  final DateFormat formatter = DateFormat('MMM dd');
  final TextEditingController textEditingController = TextEditingController();
  DateTime? date;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int?;
    final themeData = Theme.of(context);
    final List<Widget> children = [
      Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(10.0),
          height: 250,
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Здесь будут мои заметки',
                fillColor: themeData.colorScheme.background),
          )),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () async {
                final res = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 10)),
                );
                setState(() {
                  date = res;
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: SizedBox(
                width: 120,
                child: ListTile(
                  title: const Text('Дедлайн'),
                  subtitle: date == null ? null : Text(formatter.format(date!)),
                ),
              ),
            ),
            Checkbox(
              fillColor:
                  MaterialStateColor.resolveWith((states) => Colors.green),
              value: date != null,
              onChanged: (bool? value) {},
            )
          ],
        ),
      ),
    ];
    if (id != null) {
      children.add(
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
              style: TextButton.styleFrom(
                //alignment: Alignment.centerLeft,
                foregroundColor: Colors.red,
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outline_outlined,
                color: Colors.red,
              ),
              label: const Text('Удалить')),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        leading: IconButton(
          alignment: Alignment.centerLeft,
          color: Colors.black,
          iconSize: 28,
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TodoListPage()),
            );
          },
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: themeData.colorScheme.primary,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              String note = textEditingController.text;
              TodoModel model =
                  TodoModel(text: note, deadLine: date, done: false);
              TodoStorage.save(model);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TodoListPage()),
              );
            },
            child: const Text('сохранить',
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(children: children),
        ),
      ),
    );
  }
}
