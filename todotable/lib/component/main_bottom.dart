import 'package:flutter/material.dart';

class MainBottom extends StatelessWidget {
  const MainBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: const TextField(
        decoration: InputDecoration(hintText: "새로운 투두 추가하기"),
      ),
    ));
  }
}
