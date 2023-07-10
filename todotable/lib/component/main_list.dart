import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todotable/component/main_header.dart';
import 'package:todotable/database/drift_database.dart';

class MainList extends StatefulWidget {
  // final FormFieldSetter<String>? onSaved;
  // final FormFieldValidator<String>? validator;

  const MainList({
    // @required this.onSaved,
    // @required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final _textController = TextEditingController();
  String? newTodoName;
  DateTime todayDate = DateTime.now();

  Stream<List<Todo>> todoListStream = const Stream.empty();

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
                          key: Key(todoList[index].id.toString()),
                          onDismissed: (direction) async {
                            await GetIt.instance<LocalDatabase>()
                                .removeTodos(todoList[index].id);
                            // print(todo.completedAt);
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
                                    onChanged: (value) {
                                      final newCompletedAt =
                                          value != null && value
                                              ? DateTime.now()
                                              : null;
                                      GetIt.instance<LocalDatabase>()
                                          .updateTodoCompletedAt(
                                              todo.id, newCompletedAt);
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
