import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:muramura/model/diary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryRepository {
  static const String _DIARY = 'diary';
  static const String _API_URL = 'http://localhost:5000';
  DiaryRepository();

  Future<DiaryEntries> getDiaryList(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('diary');
    if (jsonString == null) {
      return DiaryEntries(diary: {});
    }

    return DiaryEntries.fromJson(jsonDecode(jsonString));
  }

  Future<bool> addDiary(DateTime date, DiaryModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DiaryEntries diaryEntries = await getDiaryList(date);
    diaryEntries.add(date, data);

    return await prefs.setString(_DIARY, jsonEncode(diaryEntries.toJson()));
  }

  // Future<DiaryModel> getDiaryByVoice(DiaryModel data) async {
  //   final dio = Dio();
  //   final response = await dio.post(_API_URL, data: data.toJson());
  // }
}
