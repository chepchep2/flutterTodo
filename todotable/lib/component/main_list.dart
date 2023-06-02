import 'package:flutter/material.dart';
import 'package:todotable/component/main_bottom.dart';
import 'package:todotable/component/main_header.dart';

class MainList extends StatefulWidget {
  const MainList({super.key});

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<String> todoList = ["투두 타이틀0", "투두 타이틀1", "투두 타이틀2"];
  List<String> descriptionList = ["투두 설명을 추가할 수 있습니다"];

  DateTime todayDate = DateTime.now();

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainHeader(todayDate: todayDate, count: 0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      fillColor: const MaterialStatePropertyAll(Colors.black),
                      value: isChecked,
                      onChanged: (value) {
                        setState(
                          () {
                            isChecked = value;
                          },
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todoList[1],
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          descriptionList[0],
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
                const MainBottom(),
              ],
            ),
          );
        },
      ),
    );
  }
}
