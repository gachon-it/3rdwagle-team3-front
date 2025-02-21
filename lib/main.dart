import 'package:flutter/material.dart';
// intl 추가해야 함 - pubspec.yaml에에
import 'package:intl/date_symbol_data_local.dart';
import 'package:muramura/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(
    MaterialApp(
      theme: ThemeData(
        // 다른 귀여운 폰트....
        fontFamily: 'BlackHanSans',
      ),
      home: HomeScreen(),
    ),
  );
}
