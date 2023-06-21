import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:todotable/database/drift_database.dart';

class MainList extends StatefulWidget {
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const MainList({
    @required this.onSaved,
    @required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final _textController = TextEditingController();
  // int? todoCount;
  // String? todoList;
  String? newTodoName;

  List<String> todos = [];
  List<bool> checkedList = [];
  List<DateTime> addedTimes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final todoList = await GetIt.instance<LocalDatabase>().getTodos();
      print(todoList);
      print(todoList.length);
    });
  }

  void _handleSubmitted() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await GetIt.instance<LocalDatabase>().createdTodos(
        name: newTodoName!,
      );
    }
  }

  DateTime todayDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // print("새로운 브랜치입니다.");
    return Form(
      key: formKey,
      child: Padding(
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
                    onPressed: _handleSubmitted,
                    icon: const Icon(Icons.add),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "새로운 투두 추가하기",
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    onSaved: (String? val) {
                      newTodoName = val;
                    },
                    validator: toDoValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // void onSavePressed() {
  //   if (formKey.currentState!.validate()) {
  //     formKey.currentState!.save();
  //   }
  // }

  String? toDoValidator(String? val) {
    if (val == null) {
      return "올바른 값을 입력하세요.";
    }
    return null;
  }
}
