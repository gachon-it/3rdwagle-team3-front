import 'package:flutter/material.dart';
import 'package:muramura/model/diary.dart';
import 'package:muramura/repository/diary_repository.dart';

class HomeScreenViewmodel extends ChangeNotifier {
  List<String> emotions = [];
  List<DiaryModel> diaryList = [];

  Future<void> getEmotions(DateTime date) async {
    List<String> emotions0 = List.generate(
        DateTime(date.year, date.month + 1, 0).day, (_) => 'empty');
    final diaryEntry = await DiaryRepository().loadDiaryStroage();
    for (var i = 1; i <= emotions0.length; i++) {
      if (diaryEntry.diary.containsKey(DateTime(date.year, date.month, i))) {
        emotions0[i - 1] =
            diaryEntry.diary[DateTime(date.year, date.month, i)]!.last.emotion;
      }
    }
    emotions = emotions0;
    notifyListeners();
  }

  Future<void> getDiaryList(DateTime date) async {
    diaryList = await DiaryRepository()
        .getDiaryList(DateTime(date.year, date.month, date.day));
    notifyListeners();
  }

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
