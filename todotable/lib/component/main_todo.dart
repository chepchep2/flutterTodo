import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  Todo({
    required this.title,
    required this.description,
  });
}

class MainTodo extends StatefulWidget {
  const MainTodo({super.key});

  @override
  State<MainTodo> createState() => _MainTodoState();
}

class _MainTodoState extends State<MainTodo> {
  String title = "";
  String description = "";
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: const [],
          )
        ],
      ),
    );
  }
}
