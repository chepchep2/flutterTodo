import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todotable/database/drift_database.dart';

class MainBottom extends StatelessWidget {
  MainBottom({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();

  String? newTodoName;

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _handleSubmitted() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        await GetIt.instance<LocalDatabase>().createdTodos(
          name: newTodoName!,
        );
      }
    }

    return Form(
      key: formKey,
      child: Row(
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
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              onSaved: (String? val) {
                newTodoName = val;
              },
              validator: toDoValidator,
            ),
          ),
        ],
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
