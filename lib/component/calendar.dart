import 'package:flutter/material.dart';
import 'package:muramura/const/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;
  final bool Function(DateTime day)? selectedDayPredicate;

  const Calendar({
    required this.focusedDay,
    required this.onDaySelected,
    required this.selectedDayPredicate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: Colors.grey[200]!,
        width: 1.0,
      ),
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );

    // 날짜 셀 빌더 함수
    Widget Function(BuildContext, DateTime, DateTime) _cellBuilder(
      BoxDecoration decoration,
      TextStyle textStyle,
    ) {
      return (context, day, focusedDay) {
        return Container(
          decoration: decoration,
          child: Column(
            children: [
              Text(
                '${day.day}',
                style: textStyle,
              ),
              const SizedBox(height: 4),
              // 임시 이미지 (나중에 실제 감정 이미지로 교체)
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13.0),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  // 실제 구현 시에는 아래와 같이 Image 위젯을 사용
                  // child: Image.asset('path_to_emotion_image'),
                ),
              ),
            ],
          ),
        );
      };
    }

    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        defaultDecoration: defaultBoxDecoration,
        weekendDecoration: defaultBoxDecoration,
        selectedDecoration: defaultBoxDecoration.copyWith(
          border: Border.all(
            color: primaryColor,
            width: 1.0,
          ),
        ),
        todayDecoration: defaultBoxDecoration.copyWith(
          color: primaryColor,
        ),
        outsideDecoration: defaultBoxDecoration.copyWith(
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: primaryColor,
        ),
      ),
      // 커스텀 날짜 셀 빌더 설정
      calendarBuilders: CalendarBuilders(
        defaultBuilder: _cellBuilder(
          defaultBoxDecoration,
          defaultTextStyle,
        ),
        selectedBuilder: _cellBuilder(
          defaultBoxDecoration.copyWith(
            border: Border.all(
              color: primaryColor,
              width: 1.0,
            ),
          ),
          defaultTextStyle.copyWith(
            color: primaryColor,
          ),
        ),
        todayBuilder: _cellBuilder(
          defaultBoxDecoration.copyWith(
            color: primaryColor,
          ),
          defaultTextStyle.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: selectedDayPredicate,
    );
  }
}
