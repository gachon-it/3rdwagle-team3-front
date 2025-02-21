// 메인 홈 화면
// = 캘린더, 추가 버튼 존재재

import 'package:flutter/material.dart';
import 'package:muramura/component/diary_block.dart';
import 'package:muramura/component/today_banner.dart';
import 'package:muramura/const/colors.dart';
import 'package:muramura/component/calendar.dart';
import 'package:muramura/screen/date_detail.dart';
import 'package:muramura/screen/voice_detection.dart';
import 'package:muramura/viewmodel/home_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeScreenViewmodel>(context, listen: false)
        .getDiaryList(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeScreenViewmodel>(context);
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
          const SizedBox(height: 16),
          const TodayBanner(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: ListView.builder(
                itemCount: vm.diaryList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DateDetail(
                              date: vm.selectedDay,
                              data: vm.diaryList[index]), // 내용 전달
                        ),
                      );
                    },
                    child: DiaryBlock(
                      content: vm.diaryList[index].content.substring(0, 10),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
