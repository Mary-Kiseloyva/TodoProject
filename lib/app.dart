import 'package:flutter/material.dart';
import 'package:poni/todo_list_page/todo_list_page.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const TodoListPage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF9900),
            primary: const Color(0xFFFF9900),
            background: const Color(0xFFEDEDED),
            surface: Colors.white,

        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 24,
            height: 32 / 24,
            fontWeight: FontWeight.bold,
          )
        ),
      ),
    );
  }
}
