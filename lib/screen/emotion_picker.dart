import 'package:flutter/material.dart';
import 'package:muramura/const/colors.dart';
import 'package:muramura/screen/loading.dart';

class EmotionPicker extends StatelessWidget {
  const EmotionPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Text(
              '당신의 감정은?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  // 실제 구현 시에는 아래와 같이 Image 위젯을 사용
                  // child: Image.asset('path_to_emotion_image'),
                ),
                const SizedBox(width: 10.0),
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  // 실제 구현 시에는 아래와 같이 Image 위젯을 사용
                  // child: Image.asset('path_to_emotion_image'),
                ),
                const SizedBox(width: 10.0),
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  // 실제 구현 시에는 아래와 같이 Image 위젯을 사용
                  // child: Image.asset('path_to_emotion_image'),
                ),
              ],
            ),
            const SizedBox(height: 250),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Loading()),
                );
              },
              child: const Text(
                '완료',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
