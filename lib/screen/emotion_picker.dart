import 'package:flutter/material.dart';
import 'package:muramura/const/colors.dart';
import 'package:muramura/screen/loading.dart';
import 'package:muramura/const/emotions.dart';

class EmotionPicker extends StatefulWidget {
  const EmotionPicker({super.key});

  @override
  _EmotionPickerState createState() => _EmotionPickerState();
}

class _EmotionPickerState extends State<EmotionPicker> {
  String? selectedEmotion;

  void setEmotion(String emotion) {
    setState(() {
      selectedEmotion = emotion;
    });
  }

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
                GestureDetector(
                  onTap: () => setEmotion(Emotions.GOOD),
                  child: Image.asset(
                    'assets/img/happy.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () => setEmotion(Emotions.SOSO),
                  child: Image.asset(
                    'assets/img/soso.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () => setEmotion(Emotions.BAD),
                  child: Image.asset(
                    'assets/img/sad.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 250),
            TextButton(
              onPressed: () {
                if (selectedEmotion != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Loading(),
                    ),
                  );
                }
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
