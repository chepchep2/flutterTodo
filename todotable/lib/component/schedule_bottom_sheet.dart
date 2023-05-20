import 'package:flutter/material.dart';
import 'package:todotable/component/custom_text_field.dart';
import 'package:todotable/const/colors.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 2 + bottomInset,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom: bottomInset,
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: CustomTextField(
                      label: "시작 시간",
                      isTime: true,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: CustomTextField(
                      label: "종료 시간",
                      isTime: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Expanded(
                child: CustomTextField(
                  label: "내용",
                  isTime: false,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSavePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: const Text("저장"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSavePressed() {}
}
