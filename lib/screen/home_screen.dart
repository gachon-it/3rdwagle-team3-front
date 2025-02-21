// 메인 홈 화면
// = 캘린더, 추가 버튼 존재재

import 'package:flutter/material.dart';
import 'package:muramura/component/diary_block.dart';
import 'package:muramura/component/today_banner.dart';
import 'package:muramura/const/colors.dart';
import 'package:muramura/component/calendar.dart';
import 'package:muramura/screen/date_detail.dart';
import 'package:muramura/screen/voice_detection.dart';
import 'package:muramura/viewmodel/diary_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DiaryViewmodel>(context);
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
            onDaySelected: vm.onDaySelected,
            selectedDayPredicate: vm.selectedDayPredicate,
          ),
          const SizedBox(height: 16),
          const TodayBanner(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DateDetail(), // 내용 전달
                        ),
                      );
                    },
                    child: DiaryBlock(
                      content: '슬프다',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DateDetail(),
                        ),
                      );
                    },
                    child: DiaryBlock(
                      content: '기쁘다',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DateDetail(),
                        ),
                      );
                    },
                    child: DiaryBlock(
                      content: '집 가고 싶다',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
