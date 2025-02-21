import 'package:flutter/material.dart';
import 'package:muramura/screen/home_screen.dart';
import 'package:muramura/screen/voice_detection.dart';
import 'package:muramura/viewmodel/home_screen_viewmodel.dart';
import 'package:muramura/viewmodel/voice_detection_viewmodel.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    final vm = Provider.of<VoiceDetectionViewmodel>(context, listen: false);
    vm.onSave(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/animations/loading.gif',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 40),
            Text(
              '일기를 저장하고 있어요...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
