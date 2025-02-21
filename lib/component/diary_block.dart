// 선택한 날짜의 일기 항목 컴포넌트
//  내용

import 'package:flutter/material.dart';
import 'package:muramura/const/colors.dart';

class DiaryBlock extends StatelessWidget {
  final String content;

  const DiaryBlock({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Content(
                  content: content,
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  // 실제 구현 시에는 아래와 같이 Image 위젯을 사용
                  // child: Image.asset('path_to_emotion_image'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // -> 최대한 넓게 늘리기
      child: Text(content), // 왜 텍스트로 감싸지?
    );
  }
}
