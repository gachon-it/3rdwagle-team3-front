import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muramura/model/diary.dart';
import 'package:muramura/repository/diary_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class VoiceDetectionViewmodel extends ChangeNotifier {
  final _record = AudioRecorder();

  bool isRecording = false;
  String? savedFilePath;
  String? emotion;

  Future<String> getInternalStoragePath(
    String fileName,
  ) async {
    // 앱 내부 저장소 디렉토리 가져오기
    Directory appDir = await getTemporaryDirectory();

    return "${appDir.path}/$fileName";
  }

  //녹음 시작
  Future<void> startRecording() async {
    if (await _record.hasPermission()) {
      await _record.start(
        RecordConfig(),
        path: await getInternalStoragePath('${DateTime.now()}.m4a'),
      );
      isRecording = true;
      notifyListeners(); // UI 업데이트
    }
  }

  // 녹음 종료
  Future<void> stopRecording() async {
    savedFilePath = await _record.stop();
    isRecording = false;
    notifyListeners(); // UI 업데이트
  }

  // 녹음 중지 (에러 처리용)
  Future<void> cancelRecording() async {
    await _record.stop();
    isRecording = false;
    savedFilePath = null;
    notifyListeners();
  }

  void handleTap() {
    if (isRecording) {
      stopRecording();
    } else {
      startRecording();
    }
  }

  void onSave() {
    DiaryRepository().addDiaryFromAI(DateTime.now(), savedFilePath!, emotion!);
  }
}
