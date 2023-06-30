import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todotable/component/main_header.dart';
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
  DateTime todayDate = DateTime.now();
  String? newTodoName;

  Stream<List<Todo>> todoListStream = const Stream.empty();
  // Stream.empty()는 빈 스트림을 생성하는 역할을 한다.
  // 처음에는 데이터가 없는 상태로 초기화된다.
  // todoListStream은 투두리스트에 대한 비동기 데이터 스트림을 나타내며,
  // 데이터베이스에서 가져오는 투두리스트를 반영하여 UI를 업데이트하는 데 사용된다.

  @override
  void initState() {
    super.initState();
    todoListStream = GetIt.instance<LocalDatabase>().getTodos();
  }

  void _handleSubmitted() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await GetIt.instance<LocalDatabase>().createdTodos(
        name: newTodoName!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: StreamBuilder(
            // 해당 데이터가 변경이 되면 UI를 업데이트 하는데 사용된다.
            // stream: 비동기 데이터 스트림을 지정한다. 데이터의 변경 사항을 전달하는 이벤트를 생성한다.
            // builder: 데이터가 변경될때마다 호출되는 콜백 함수를 정의한다.
            // 이 콜백함수는 현재 데이터의 스냅샷을 받아와 UI위젯을 생성하고 업데이트한다.
            stream: todoListStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final List<Todo> todoList = snapshot.data!;
              final todoCount = todoList.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainHeader(
                    todayDate: todayDate,
                    count: todoCount,
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        final todo = todoList[index];

                        return Dismissible(
                          key: Key(todo.id.toString()),
                          // Dismissible은 유니한 키값을 가진다.
                          // key:에는 Key타입이 들어와야하고 그 Key에는 String타입의 매개변수를 갖는다
                          // 데이터베이스에 id값을 테이블에 구현했기 때문에 todo의 id를 받아오고 (todo의 id는 int값이기때문에 toString()을 써서 String으로 바꿔준다.)
                          onDismissed: (direction) async {
                            await GetIt.instance<LocalDatabase>()
                                .removeTodos(todo.id);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                    fillColor: const MaterialStatePropertyAll(
                                        Colors.black),
                                    value:
                                        todo.completedAt == null ? false : true,
                                    // todo.completedAt이 null이면 false null이 아니면 true
                                    onChanged: (value) {
                                      // todo.completedAt update
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        todo.name,
                                        style: TextStyle(
                                            fontSize: 15,
                                            decoration: todo.completedAt != null
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        todo.name,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
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
                  const SizedBox(height: 30),
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
              );
            }),
      ),
    );
  }

  String? toDoValidator(String? val) {
    if (val == null) {
      return "올바른 값을 입력하세요.";
    }
    return null;
  }
}
