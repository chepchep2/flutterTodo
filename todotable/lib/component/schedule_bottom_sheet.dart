import 'package:flutter/material.dart';
import 'package:todotable/component/custom_text_field.dart';
import 'package:todotable/const/colors.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:todotable/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  const ScheduleBottomSheet({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      // Form: 텍스트 필드를 한 번에 관리할 수 있는 폼
      key: formKey,
      // formKey: Form을 조작할 키값
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding:
                EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "시작 시간",
                        isTime: true,
                        onSaved: (String? val) {
                          startTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        label: "종료 시간",
                        isTime: true,
                        onSaved: (String? val) {
                          endTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: CustomTextField(
                    label: "내용",
                    isTime: false,
                    onSaved: (String? val) {
                      content = val;
                    },
                    validator: contentValidator,
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
      ),
    );
  }

  void onSavePressed() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await GetIt.I<LocalDatabase>().createSchedule(
        // GetIt을 통해 미리 생성해둔 LocalDatabase 인스턴스를 가져온 후 createSchedule함수 실행
        SchedulesCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          date: Value(widget.selectedDate),
          // 매개변수에 꼭 SchedulesCompanio을 입력해줘야 하는데 SchedulesCompanion에는 실제 Schedules 테이블에
          // 입력될 값들을 드리프트 패키지에서 제공하는 Value라는 클래스로 감싸서 입력해주면 된다.
        ),
      );
      Navigator.of(context).pop();
      // 일정 생성 후 화면 뒤로 가기
    }
  }

  // 시간 검증 함수
  String? timeValidator(String? val) {
    if (val == null) {
      return "값을 입력해주세요.";
    }
    int? number;

    try {
      number = int.parse(val);
    } catch (e) {
      return "숫자를 입력해주세요.";
    }

    if (number < 0 || number > 24) {
      return "0시부터 24시 사이를 입력해주세요.";
    }

    return null;
  }

  // 내용 검증 함수
  String? contentValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "값을 입력해주세요.";
    }
    return null;
  }
}
