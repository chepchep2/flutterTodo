import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  List<bool> checkedList = [];
  List<DateTime> addedTimes = [];
  final _textController = TextEditingController();

  void _handleSubmitted() {
    setState(() {
      String newTodo = _textController.text;
      todos.add(newTodo);
      checkedList.add(false);
      addedTimes.add(DateTime.now());
      _textController.clear();
    });
  }

  DateTime todayDate = DateTime.now();

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
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                final addedTime = addedTimes[index];
                final formattedTime = DateFormat.Hm().format(addedTime);
                return Dismissible(
                  key: Key(todo),
                  onDismissed: (direction) {
                    setState(() {
                      todos.removeAt(index);
                      checkedList.removeAt(index);
                      addedTimes.removeAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            fillColor:
                                const MaterialStatePropertyAll(Colors.black),
                            value: checkedList[index],
                            onChanged: (value) {
                              setState(() {
                                checkedList[index] = value!;
                              });
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todo,
                                style: TextStyle(
                                    fontSize: 15,
                                    decoration: checkedList[index]
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                todo,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Text(
                            formattedTime,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
            ),
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
                  decoration: const InputDecoration(
                    hintText: "새로운 투두 추가하기",
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
