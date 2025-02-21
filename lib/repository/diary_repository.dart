import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:muramura/dto/diary_receive.dart';
import 'package:muramura/dto/diary_request.dart';

import 'package:muramura/model/diary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryRepository {
  static const String _DIARY = 'diary';
  static const String _API_URL = 'http://localhost:5000/api/stt';

  DiaryRepository();

  Future<DiaryEntry> loadDiaryStroage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('diary');
    if (jsonString == null) {
      return DiaryEntry(diary: {});
    }
    try {
      return DiaryEntry.fromJson(jsonDecode(jsonString));
    } catch (e) {
      prefs.clear();
      throw Exception(e);
    }
  }

  Future<DiaryEntry> getDiaryEntry(DateTime date) async {
    DiaryEntry diaryEntry = await loadDiaryStroage();
    DiaryEntry diaryEntry0 = DiaryEntry(diary: {date: diaryEntry.diary[date]!});
    return diaryEntry0;
  }

  Future<List<DiaryModel>> getDiaryList(DateTime date) async {
    DiaryEntry diaryEntry = await loadDiaryStroage();
    return diaryEntry.get(date) ?? [];
  }

  Future<bool> addDiary(DateTime date, DiaryModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DiaryEntry diaryEntry = await loadDiaryStroage();
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
        "audio": await MultipartFile.fromFile(filePath),
        "emotion": emotion,
      },
    );

    final response = await uploadMultiMediaFile(_API_URL, formData);

    try {
      if (response.statusCode == 200) {
        print(response.data.toString());
        final receive = DiaryReceive.fromJson(response.data);
        return DiaryModel(
            content: receive.text, emotion: emotion, comment: receive.comment);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DiaryModel> addDiaryFromAI(
      DateTime date, String filePath, String emotion) async {
    final data = await getDiaryFromAI(filePath, emotion);
    await addDiary(date, data);
    // 파일 검증
    return data;
  }

  // 멀티미디어어 파일을 전송하는 함수
  Future<Response> uploadMultiMediaFile(String url, FormData formData) async {
    var dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 120), // 연결 타임아웃 (예: 15초)
        receiveTimeout: const Duration(seconds: 120), // 응답 대기 타임아웃
      ),
    );
    return dio.post(url,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
        }),
        data: formData);
  }
}
