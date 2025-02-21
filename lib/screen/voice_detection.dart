import 'package:flutter/material.dart';
import 'package:muramura/const/colors.dart';
import 'package:muramura/screen/loading.dart';
import 'package:muramura/screen/result_screen.dart';

class VoiceDetection extends StatefulWidget {
  const VoiceDetection({Key? key}) : super(key: key);

  @override
  State<VoiceDetection> createState() => _VoiceDetectionState();
}

class _VoiceDetectionState extends State<VoiceDetection> {
  bool _isListening = false;
  bool _isRecordingDone = false; // 녹음 완료 상태 추가

  void _resetRecording() {
    setState(() {
      _isListening = false;
      _isRecordingDone = false;
    });
  }

  void _saveRecording() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Loading(),
      ),
    );
  }

  // 서버 통신을 시뮬레이션하는 Future 함수 추가
  Future<Map<String, dynamic>> processVoiceData() async {
    await Future.delayed(const Duration(seconds: 3));
    return {
      'text': '오늘은 정말 좋은 날이었어요...',
      'emotion': 'happy',
    };
  }

  void _handleSave() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => FutureBuilder(
        future: processVoiceData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }

          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(),
                ),
              );
            });
          }

          return const Loading();
        },
      ),
    );
  }

  void _handleTap() {
    setState(() {
      if (_isListening) {
        // 녹음 중 -> 녹음 완료(정사각형)
        _isListening = false;
        _isRecordingDone = true;
      } else if (_isRecordingDone) {
        // 녹음 완료 -> 새로운 녹음 시작(다시하기)
        _isRecordingDone = false;
        _isListening = true;
      } else {
        // 초기 상태 -> 녹음 시작(마이크)
        _isListening = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일기 쓰기'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            GestureDetector(
              onTap: _handleTap,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: Icon(
                  _isListening
                      ? Icons.stop
                      : (_isRecordingDone ? Icons.refresh : Icons.mic_rounded),
                  size: 80,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  if (_isListening) ...[
                    const SizedBox(height: 40),
                    Text(
                      '듣고 있어요...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ] else if (_isRecordingDone) ...[
                    const SizedBox(height: 40),
                    Text(
                      '다시 녹음하시려면 버튼을 눌러주세요',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: primaryColor,
                          width: 1,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Loading()),
                          );
                        },
                        child: const Text(
                          '저장',
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    )
                  ] else ...[
                    const SizedBox(height: 40),
                    Text(
                      '마이크를 눌러서\n일기 쓰기를 시작하세요',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
