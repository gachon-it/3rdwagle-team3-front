import 'package:flutter/material.dart';

class DiaryViewmodel extends ChangeNotifier {
  // 선택된 날짜를 관리할 변수
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    notifyListeners();
  }

  bool selectedDayPredicate(DateTime date) {
    return date.isAtSameMomentAs(selectedDay);
  }
}
