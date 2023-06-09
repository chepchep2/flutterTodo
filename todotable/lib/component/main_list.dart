import 'package:flutter/material.dart';

class MainList extends StatelessWidget {
  final String todoName;
  final bool todoCompleted;
  Function(bool?)? onChanged;
  final String todoSub;
  // bool일수도 아닐수도? ?하나가 더 붙는 이유는?

  MainList({
    required this.onChanged,
    required this.todoCompleted,
    required this.todoName,
    required this.todoSub,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(123);
    print("test");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Checkbox(
                  value: todoCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todoName,
                      style: TextStyle(
                        decoration: todoCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 20,
                      ),
                    ),
                    Text(todoSub),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(60, 60),
                        elevation: 10),
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                      right: 20,
                      left: 5,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "투두 추가ddddddd",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

int hamsoo(int a) {
  print("abc");
  return a;
}
