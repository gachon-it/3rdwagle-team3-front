import 'package:flutter/material.dart';
// intl 추가해야 함 - pubspec.yaml에
import 'package:intl/date_symbol_data_local.dart';
import 'package:muramura/screen/home_screen.dart';
import 'package:muramura/viewmodel/diary_input_viewmodel.dart';
import 'package:muramura/viewmodel/diary_viewmodel.dart';
import 'package:muramura/viewmodel/voice_detection_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DiaryViewmodel()),
        ChangeNotifierProvider(create: (_) => DiaryInputViewmodel()),
        ChangeNotifierProvider(create: (_) => VoiceDetectionViewmodel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          // 다른 귀여운 폰트....
          fontFamily: 'BlackHanSans',
        ),
        home: HomeScreen(),
      ),
    ),
  );
}
