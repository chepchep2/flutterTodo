import 'package:flutter/material.dart';
import 'package:todotable/component/main_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List todoList = [
    ["투두 타이틀", false, "투두 설명을 추가할 수 있습니다"],
    ["스토리라인 작업하기", false, "투두 설명은 작성 시 60%로 설정합니다"],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  // void createNewTodo() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const MainAdd();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: createNewTodo,
      //   child: const Icon(Icons.add),
      // ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return MainList(
            todoName: todoList[index][0],
            todoCompleted: todoList[index][1],
            todoSub: todoList[index][2],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
