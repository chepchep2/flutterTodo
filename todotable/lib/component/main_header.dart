import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final DateTime todayDate;
  final int count;

  const MainHeader({
    required this.todayDate,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 40,
        ),
        Text(
          "오늘의 투두 $count",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
