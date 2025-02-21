import 'package:flutter/material.dart';
import 'package:muramura/model/diary.dart';
import 'package:muramura/screen/home_screen.dart';
import 'package:muramura/viewmodel/home_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class DateDetail extends StatelessWidget {
  DateTime date;
  DiaryModel data;
  DateDetail({super.key, required this.date, required this.data});

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeScreenViewmodel>(context).getDiaryList(date);
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 일기'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      date.toIso8601String().split('T')[0],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: 300,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(8), // iOS 스타일의 부드러운 모서리
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // 그림자 색상과 투명도
                              offset: const Offset(0, 4), // 수직으로 4px 이동한 그림자
                              blurRadius: 8.0, // 그림자 블러 효과
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data.content),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      '코멘트',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: 100,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(8), // iOS 스타일의 부드러운 모서리
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // 그림자 색상과 투명도
                              offset: const Offset(0, 4), // 수직으로 4px 이동한 그림자
                              blurRadius: 8.0, // 그림자 블러 효과
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data.comment),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
