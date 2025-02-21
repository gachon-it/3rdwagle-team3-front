import 'package:flutter/material.dart';
// intl 추가해야 함 - pubspec.yaml에
import 'package:intl/date_symbol_data_local.dart';
import 'package:muramura/repository/diary_repository.dart';
import 'package:muramura/screen/home_screen.dart';
import 'package:muramura/viewmodel/date_detail_viewmodel.dart';
import 'package:muramura/viewmodel/home_screen_viewmodel.dart';
import 'package:muramura/viewmodel/voice_detection_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenViewmodel()),
        ChangeNotifierProvider(create: (_) => DateDetailViewModel()),
        ChangeNotifierProvider(create: (_) => VoiceDetectionViewmodel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // 다른 귀여운 폰트....
          fontFamily: 'BlackHanSans',
        ),
        home: HomeScreen(),
      ),
    ),
  );
}

void test() async {
  final data = await DiaryRepository()
      .getDiaryFromAI("C:\\Users\\kmj02\\Downloads\\yourvoice.wav", "Good");
  print('${data.comment} ${data.content}, ${data.emotion}');
}
