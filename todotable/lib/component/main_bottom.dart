import 'package:flutter/material.dart';

class MainBottom extends StatefulWidget {
  const MainBottom({super.key});

  @override
  State<MainBottom> createState() => _MainBottomState();
}

class _MainBottomState extends State<MainBottom> {
  final _textController = TextEditingController();
  List todos = [];
  String input = "";
  @override
  Widget build(BuildContext context) {
    void _handleSubmitted(String text) {
      // _textController.clear();
      print(text);
    }

    return Container(
      child: Row(
        children:
            // <Widget> 있어도 되고 없어도 되는 것 같음 용도는??
            [
          Container(
            child: IconButton(
                onPressed: () => _handleSubmitted(_textController.text),
                icon: const Icon(Icons.add)),
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration:
                  const InputDecoration.collapsed(hintText: "새로운 투두 추가하기"),
            ),
          ),
        ],
      ),
    );
  }
}
