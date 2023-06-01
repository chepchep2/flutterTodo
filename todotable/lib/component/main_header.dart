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
        Text("${todayDate.month}월 ${todayDate.day}일"),
        Text("오늘의 투두 $count")
      ],
    );
  }
}
