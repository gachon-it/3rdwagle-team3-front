import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:muramura/dto/diary_receive.dart';
import 'package:muramura/dto/diary_request.dart';

import 'package:muramura/model/diary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryRepository {
  static const String _DIARY = 'diary';
  static const String _API_URL = 'http://localhost:5000';
  DiaryRepository();

  Future<DiaryEntry> getDiaryList(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('diary');
    if (jsonString == null) {
      return DiaryEntry(diary: {});
    }

    return DiaryEntry.fromJson(jsonDecode(jsonString));
  }

  Future<bool> addDiary(DateTime date, DiaryModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DiaryEntry diaryEntry = await getDiaryList(date);
    diaryEntry.add(date, data);

    return await prefs.setString(_DIARY, jsonEncode(diaryEntry.toJson()));
  }

  Future<bool> modifyDiary(DateTime date, DiaryModel data) async {
    throw UnimplementedError();
  }

  Future<bool> deleteDiary(DateTime date, String diaryId) async {
    throw UnimplementedError();
  }

  // 서버로 음성을 보내 다이어리를 얻는 함수
  Future<DiaryModel> getDiaryFromAI(String filePath, String emotion) async {
    // FormData 생성
    FormData formData = FormData.fromMap(
      {
        "file": filePath,
        "emotion": emotion,
      },
    );

    final response = await uploadMultiMediaFile(_API_URL, formData);

    try {
      if (response.statusCode == 200) {
        final receive = DiaryReceive.fromJson(response.data);
        return DiaryModel(
            content: receive.text, emotion: emotion, comment: receive.comment);
      } else {
        throw Exception();
      }
    } catch (e) {
      print("업로드 중 오류 발생: $e");
      throw Exception();
    }
  }

  // 멀티미디어어 파일을 전송하는 함수
  Future<Response> uploadMultiMediaFile(String url, FormData formData) async {
    var dio = Dio();
    return dio.post(url, data: formData);
  }
}
