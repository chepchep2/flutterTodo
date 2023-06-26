import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
  String? newTodoName;

  List<bool> checkedList = [];

  Stream<List<Todo>> todoListCount = const Stream.empty();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final todoList = GetIt.instance<LocalDatabase>().getTodos();
      final todoCount = GetIt.instance<LocalDatabase>().getTodos();
      setState(() {
        todoListCount = todoCount;
      });

      todoList.listen((event) {
        setState(() {
          // checkedList = List<bool>.filled(event.length, false);
          // checkedList 길이가 고정되어 있음
          // filled() 생성자를 사용하면 모든 원소들이 false로 채워진 고정 길이 리스트가 생성된다.
          checkedList = List.generate(event.length, (index) => false);
          // 리스트의 길이를 가변으로 바꿔준다.
          // List.generate()를 사용하여 원하는 길이로 초기화하고 모든 원소를 'false'로 설정할 수 있다.
        });
      });
    });
  }

  void _handleSubmitted() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await GetIt.instance<LocalDatabase>().createdTodos(
        name: newTodoName!,
      );

      setState(() {
        checkedList.add(false);
      });
      // checkedList.add(false);
    }
  }

  DateTime todayDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: todoListCount,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }

                final todoCount = snapshot.data!.length;

                return Text(
                  "오늘의 투두 $todoCount",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                );
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: StreamBuilder(
                stream: GetIt.I<LocalDatabase>().getTodos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  // print("snapshot.data: ${snapshot.data}");
                  // print("chepchep");
                  final List<Todo> todoList1 = snapshot.data!;
                  // const List<bool> checkedList = [];
                  // print(todoList1.length);

                  return ListView.builder(
                    itemCount: todoList1.length,
                    itemBuilder: (context, index) {
                      final todo = todoList1[index].name;
                      return Dismissible(
                        key: Key(todoList1[index].id.toString()),
                        // onDismissed: (direction) {
                        //   // setState(() {
                        //   //   todoList1.removeAt(index);
                        //   //   todoList1.removeAt(index);
                        //   // });
                        // },
                        onDismissed: (direction) async {
                          await GetIt.instance<LocalDatabase>()
                              .removeTodos(todoList1[index].id);
                          setState(() {
                            todoList1.removeAt(index);
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
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.black),
                                  value: checkedList[index],
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        checkedList[index] = value ?? false;
                                      },
                                    );
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
                                // Text(
                                //   formattedTime,
                                //   style: const TextStyle(
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      );
                    },
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
        ),
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
