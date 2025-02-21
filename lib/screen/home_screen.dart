// 메인 홈 화면
// = 캘린더, 추가 버튼 존재재

import 'package:flutter/material.dart';
import 'package:muramura/const/colors.dart';
import 'package:muramura/component/calendar.dart';
import 'package:muramura/screen/voice_detection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 선택된 날짜를 관리할 변수
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VoiceDetection(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: SafeArea(
          child: Column(
        children: [
          Calendar(
            focusedDay: DateTime(2025, 2, 1),
            onDaySelected: onDaySelected,
            selectedDayPredicate: selectedDayPredicate,
          ),
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: ListView(
                children: [
                  // 자식 결과들 배치
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime date) {
    if (selectedDay == null) {
      return false;
    }
    return date.isAtSameMomentAs(selectedDay!);
  }
}
