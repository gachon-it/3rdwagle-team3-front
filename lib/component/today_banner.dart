import 'package:flutter/material.dart';
import 'package:muramura/const/colors.dart';
import 'package:muramura/viewmodel/home_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class TodayBanner extends StatelessWidget {
  const TodayBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedDay = context.watch<HomeScreenViewmodel>().selectedDay;
    return Container(
      color: primaryColor,
      child: Padding(
        // padding: EdgeInsets.symmetric: 디자인이 글자와 주위 요소간의 간격이 생기게 도움움
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
