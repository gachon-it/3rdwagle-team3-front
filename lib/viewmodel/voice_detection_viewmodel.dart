import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VoiceDetectionViewmodel extends ChangeNotifier {
  bool isListening = false;
  bool isRecordingDone = false; // 녹음 완료 상태 추가

  void resetRecording() {
    isListening = false;
    isRecordingDone = false;
    notifyListeners();
  }

  // 서버 통신을 시뮬레이션하는 Future 함수 추가
  // Future<Map<String, dynamic>> processVoiceData() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   return {
  //     'text': '오늘은 정말 좋은 날이었어요...',
  //     'emotion': 'happy',
  //   };
  // }

  // void _handleSave() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => FutureBuilder(
  //       future: processVoiceData(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Loading();
  //         }

  //         if (snapshot.hasData) {
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => ResultScreen(),
  //               ),
  //             );
  //           });
  //         }

  //         return const Loading();
  //       },
  //     ),
  //   );
  // }

  void handleTap() {
    if (isListening) {
      // 녹음 중 -> 녹음 완료(정사각형)
      isListening = false;
      isRecordingDone = true;
    } else if (isRecordingDone) {
      // 녹음 완료 -> 새로운 녹음 시작(다시하기)
      isRecordingDone = false;
      isListening = true;
    } else {
      // 초기 상태 -> 녹음 시작(마이크)
      isListening = true;
    }
    notifyListeners();
  }
}
