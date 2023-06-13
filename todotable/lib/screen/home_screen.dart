import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todotable/component/main_calendar.dart';
import 'package:todotable/component/schedule_bottom_sheet.dart';
import 'package:todotable/component/schedule_card.dart';
import 'package:todotable/component/today_banner.dart';
import 'package:todotable/const/colors.dart';
import 'package:todotable/database/drift_database.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SafeArea(
//         child: MainList(),
//       ),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => ScheduleBottomSheet(
              // 선택된 날짜 넘겨주기
              selectedDate: selectedDate,
            ),
            isScrollControlled: true,
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            const SizedBox(height: 8),
            StreamBuilder<List<Schedule>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
              // 일정 stream으로 받아오기
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  count: snapshot.data?.length ?? 0,
                );
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<List<Schedule>>(
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                // GetIt으로 LocalDatabase 인스턴스롤 가져와서 watchSchedules함수 실행
                // watchSchedules함수는 Stream을 반환한다. Streambuilder를 사용해서 일정 관련 데이터가 변경될 때마다
                // 위젯들을 새로 렌더링 해준다.
                // 매개변수로 selectedDate를 받아서 선택한 날짜의 일정만 따로 필터링해서 불러온다.
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // 데이터가 없을 때
                    // 일정이 존재하지않으면 Container반환
                    return Container();
                  }
                  return ListView.builder(
                    // 화면에 보이는 값들만 렌더링하는 리스트
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final Schedule = snapshot.data![index];
                      return Dismissible(
                        key: ObjectKey(Schedule.id),
                        // 유니크한 키값
                        direction: DismissDirection.startToEnd,
                        onDismissed: (DismissDirection direction) {
                          GetIt.I<LocalDatabase>().removeSchedule(Schedule.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, left: 8, right: 8),
                          child: ScheduleCard(
                            startTime: Schedule.startTime,
                            endTime: Schedule.endTime,
                            content: Schedule.content,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
