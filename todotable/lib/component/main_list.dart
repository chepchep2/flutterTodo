import 'package:flutter/material.dart';

class MainList extends StatefulWidget {
  final DateTime? todayDate;
  final int? count;
  const MainList({
    @required this.todayDate,
    @required this.count,
    Key? key,
  }) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<String> todos = [];
  final _textController = TextEditingController();

  void _handleSubmitted() {
    setState(() {
      String newTodo = _textController.text;
      todos.add(newTodo);
      _textController.clear();
    });
  }

  DateTime todayDate = DateTime.now();

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${todayDate.month}월 ${todayDate.day}일",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "오늘의 투두 ${todos.length}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                child: IconButton(
                  onPressed: () => _handleSubmitted(),
                  icon: const Icon(Icons.add),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(hintText: "새로운 투두 추가하기"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                } else if (index == 1) {
                  return const SizedBox.shrink();
                } else {
                  final todo = todos[index - 2];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            fillColor:
                                const MaterialStatePropertyAll(Colors.black),
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value;
                              });
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todo,
                                style: const TextStyle(fontSize: 15),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                todo,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const Text(
                            "08:32",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
