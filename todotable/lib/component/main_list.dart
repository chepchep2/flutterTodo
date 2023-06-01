import 'package:flutter/material.dart';
import 'package:todotable/component/main_header.dart';

class MainList extends StatefulWidget {
  const MainList({super.key});

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  DateTime todayDate = DateTime.now();

  bool? isChecked1 = false;
  bool? isChecked2 = false;
  bool? isChecked3 = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MainHeader(
          todayDate: todayDate,
          count: 0,
        ),
        Row(
          children: [
            Checkbox(
              fillColor: const MaterialStatePropertyAll(Colors.black),
              value: isChecked1,
              onChanged: (value) {
                setState(
                  () {
                    isChecked1 = value;
                  },
                );
              },
            ),
            const Text("투두 타이틀"),
          ],
        ),
        Row(
          children: [
            Checkbox(
              fillColor: const MaterialStatePropertyAll(Colors.black),
              value: isChecked2,
              onChanged: (value) {
                setState(
                  () {
                    isChecked2 = value;
                  },
                );
              },
            ),
            const Text("투두 타이틀"),
          ],
        ),
        Row(
          children: [
            Checkbox(
              fillColor: const MaterialStatePropertyAll(Colors.black),
              value: isChecked3,
              onChanged: (value) {
                setState(
                  () {
                    isChecked3 = value;
                  },
                );
              },
            ),
            const Text("투두 타이틀"),
          ],
        ),
      ],
    );
  }
}
