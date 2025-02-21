import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:muramura/screen/home_screen.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<String> _loadingTexts = [
    '음성을 텍스트로 변환하고 있어요...',
    '감정을 분석하고 있어요...',
    '일기를 저장하고 있어요...',
  ];
  int _currentTextIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // 텍스트 변경을 위한 타이머
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentTextIndex = (_currentTextIndex + 1) % _loadingTexts.length;
      });
    });

    // 5초 후 홈 화면으로 이동
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로티 애니메이션
            Lottie.asset(
              'assets/animations/thinking_character.json', // 귀여운 캐릭터 애니메이션 파일
              controller: _controller,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 40),
            // 로딩 텍스트
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _loadingTexts[_currentTextIndex],
                key: ValueKey<int>(_currentTextIndex),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
