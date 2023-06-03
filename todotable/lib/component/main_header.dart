import 'package:flutter/material.dart';

class MainHeader extends StatefulWidget {
  final DateTime todayDate;
  final int count;

  const MainHeader({
    required this.todayDate,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.todayDate.month}월 ${widget.todayDate.day}일",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "오늘의 투두 ${widget.count}",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
