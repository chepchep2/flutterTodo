import 'package:flutter/material.dart';

class MainAdd extends StatelessWidget {
  const MainAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 120,
        child: Column(
          children: const [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "새로운 투두 추가하기",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
