import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:todotable/database/drift_database.dart';

class MainList extends StatefulWidget {
  // final DateTime? todayDate;
  // final int? count;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const MainList({
    // @required this.todayDate,
    // @required this.count,
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
  String? newTodoName;

  /*
  1. todo 의 개수?
  2. 새로운 todo 의 생성 -> DB 입력을 곁들인
  
  Divide & Conquer (분할과 정복)
  - todo 생성을 어떻게 할지?
    - todo 생성에 필요한 정보가 무엇이 있을지?
    - todo 생성 완료
  - 화면에 어떻게 그릴지?
  - 개수?
  - 삭제?
  */

  // List<Todo> todoList = [];
  List<String> todos = [];
  List<bool> checkedList = [];
  List<DateTime> addedTimes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("addPostFrameCallback");
      final todoList = await GetIt.instance<LocalDatabase>().getTodos();
      print(todoList);
      print(todoList.length);
    });

    // print(todoList);
  }

  void _handleSubmitted() async {
    // print("textController: ${_textController.text}");

    // 1. formKey.currentState!.validate() 는 오류가 나는가? 안나는가?
    // 2. 오류가 안난다면 왜 그런가?
    if (formKey.currentState!.validate()) {
      // print(formKey.currentState);
      // print("todoList before form saving: $newTodoName"); // input

      formKey.currentState!.save();
      // print("todoList after form saving: $newTodoName"); // input
      // DateTime now = DateTime.now();

      // name 에 들어오는 값은 왜 null이 아니라고 가정할 수 있을까?
      await GetIt.instance<LocalDatabase>().createTodos(
        name: newTodoName!,
      );
    }

    // formKey.currentState!.reset();
    _textController.clear();
  }

  DateTime todayDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // print("새로운 브랜치입니다.");
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
                              // void fn() {
                              //   checkedList[index] = value!;
                              // }
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
          Form(
            key: formKey,
            child: Row(
              children: [
                Container(
                  child: IconButton(
                    // onPressed: () => _handleSubmitted(),
                    // onPressed: () {
                    //   return _handleSubmitted();
                    // },
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
          ),
          const SizedBox(height: 30),
        ],
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

void nullOperator() {
  int b = 1;
  print(b);
  print(b is int);
  print(b.toString());
  print(b.toString() is String);

  var a;
  print("null test");
  print("==a");
  print(a);
  print("==a?");
  print(a?.toString());
  print(a?.toString() is String);
  print("==a!");
  print(a!.toString());

  // formKey.currentState?.validate();
  // formKey.currentState!.validate();
}

// class Todo {
//   int id;
//   String name;
//   String? description;
//   DateTime createdAt;
//   DateTime? completedAt;

//   Todo({
//     required this.id,
//     required this.name,
//     this.description,
//     required this.createdAt,
//     this.completedAt,
//   });
// }
