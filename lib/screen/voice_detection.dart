import 'package:flutter/material.dart';
import 'package:muramura/const/colors.dart';
import 'package:muramura/screen/date_detail.dart';
import 'package:muramura/screen/emotion_picker.dart';
import 'package:muramura/screen/loading.dart';
import 'package:muramura/screen/result_screen.dart';
import 'package:muramura/viewmodel/voice_detection_viewmodel.dart';

import 'package:provider/provider.dart';

class VoiceDetection extends StatelessWidget {
  const VoiceDetection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<VoiceDetectionViewmodel>(context);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        vm.init();
      },
      child: Scaffold(
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
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    vm.isRecording
                        ? Text(
                            '듣고 있어요...',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          )
                        : (vm.savedFilePath == null
                            ? Text('')
                            : Text(
                                '다시 녹음하시려면 버튼을 눌러주세요',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              )),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: vm.handleTap,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Icon(
                          vm.isRecording
                              ? Icons.stop
                              : (vm.isRecording
                                  ? Icons.refresh
                                  : Icons.mic_rounded),
                          size: 80,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    if (!vm.isRecording && vm.savedFilePath != null)
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EmotionPicker(),
                              ),
                            );
                          },
                          child: const Text(
                            '다음',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
